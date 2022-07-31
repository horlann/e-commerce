import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/data/repositories/admin/remote_admin_repositiory.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/bloc/admin/admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final RemoteRepository _remoteRepository;
  final RemoteAdminRepository _remoteAdminRepository;
  List<CategoryEntity> categories = [];
  List<Item> items = [];
  List<OrderEntity> orders = [];

  AdminBloc(this._remoteRepository, this._remoteAdminRepository) : super(const AdminState().inProgress()) {
    on<InitCategoriesEvent>(_initCategories);
    on<InitProductsEvent>(_initProducts);
    on<EditItemEvent>(_editItem);
    on<UpdateSnusItemEvent>(_updateItem);
    on<UpdateDisposableItemEvent>(_updateItem);
    on<InitOrdersEvent>(_listenOrdersStream);
    on<AddNewItemEvent>(_createItem);
    on<AddNewCategoryEvent>(_addNewCategory);
  }

  void _initCategories(AdminEvent event, Emitter<AdminState> emit) async {
    emit(state.inProgress());
    // await  _listenOrdersStream(emit);
    try {
      categories = await _remoteRepository.getCategoriesList();
      emit(state.categoriesLoaded(categories));
    } on Exception {
      state.failure();
    }
  }

  Future<void> _addNewCategory(AdminEvent event, Emitter<AdminState> emit) async {
    emit(state.inProgress());
    await _remoteRepository.createCategory((event as AddNewCategoryEvent).category, "image");
    emit(state.categoriesLoaded(categories));
  }

  void _createItem(AddNewItemEvent event, Emitter<AdminState> emit) async {
    await _remoteAdminRepository.createItem(event.item);
  }

  void _initProducts(AdminEvent event, Emitter<AdminState> emit) async {
    emit(state.inProgress());
    items = await _remoteRepository.loadAllItems();
    emit(state.productsLoaded(items));
  }

  void _editItem(AdminEvent event, Emitter<AdminState> emit) async {
    emit(state.editItem((event as EditItemEvent).item));
  }

  void _updateItem(AdminEvent event, Emitter<AdminState> emit) async {
    emit(state.inProgress());
    if (event is UpdateSnusItemEvent) {
      await _remoteAdminRepository.updateItem(event.item);
    } else if (event is UpdateDisposableItemEvent) {
      await _remoteAdminRepository.updateItem(event.item);
    }

    add(const InitProductsEvent());
  }

  Future<void> _listenOrdersStream(AdminEvent event, Emitter<AdminState> emit) async =>
      await emit.onEach(_remoteAdminRepository.ordersStream(), onData: (message) {
        emit(NewOrderState(message as List<OrderEntity>));
      });
}
