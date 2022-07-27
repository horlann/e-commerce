import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/category_entity.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/bloc/admin/admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final RemoteRepository _remoteRepository;
  List<CategoryEntity> categories = [];

  AdminBloc(this._remoteRepository) : super(const AdminState().inProgress()) {
    on<InitDataEvent>(_init);
    //on<AddNewItemEvent>();
    on<AddNewCategoryEvent>(_addNewCategory);
  }

  void _init(AdminEvent event, Emitter<AdminState> emit) async {
    emit(state.inProgress());
    final result = await _remoteRepository.getCategoriesList();
    result.fold((l) => emit(state.failure()), (r) {
      categories = r;
      emit(state.dataLoaded(r));
    });
  }

  void _addNewCategory(AdminEvent event, Emitter<AdminState> emit) async {
    emit(state.inProgress());
    await _remoteRepository.addNewCategory((event as AddNewCategoryEvent).category, "image");
    emit(state.dataLoaded(categories));
  }
}