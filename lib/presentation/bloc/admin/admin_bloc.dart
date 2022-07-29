import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/data/repositories/admin/remote_admin_repositiory.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/bloc/admin/admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final RemoteRepository _remoteRepository;
  final RemoteAdminRepository _remoteAdminRepository;
  List<CategoryEntity> categories = [];

  AdminBloc(this._remoteRepository, this._remoteAdminRepository) : super(const AdminState().inProgress()) {
    on<InitCategoriesEvent>(_initCategories);
    on<InitOrdersEvent>(_listenOrdersStream);
    on<AddNewItemEvent>(_createItem);
    on<AddNewCategoryEvent>(_addNewCategory);
  }

  List<OrderEntity> orders = [];

  void _initCategories(AdminEvent event, Emitter<AdminState> emit) async {
    emit(state.inProgress());
    try {
      categories = await _remoteRepository.getCategoriesList();
      emit(state.categoriesLoaded(categories));
    } on Exception {
      state.failure();
    }
  }

  Future<void> _addNewCategory(AdminEvent event, Emitter<AdminState> emit) async {
    emit(state.inProgress());
    await _remoteAdminRepository.createCategory((event as AddNewCategoryEvent).category, "image");
    emit(state.categoriesLoaded(categories));
  }

  void _createItem(AdminEvent event, Emitter<AdminState> emit) async {
    await _remoteAdminRepository.createItem();
  }

  Future<void> _listenOrdersStream(AdminEvent event, Emitter<AdminState> emit) async =>
      await emit.onEach(_remoteAdminRepository.ordersStream(), onData: (message) {
        emit(NewOrderState(message as List<OrderEntity>));
      });
}
