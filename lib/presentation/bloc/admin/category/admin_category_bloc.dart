import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/presentation/bloc/admin/category/admin_category_event.dart';
import 'package:kurilki/presentation/bloc/admin/category/admin_category_state.dart';

class AdminCategoryBloc extends Bloc<AdminCategoryEvent, AdminCategoryState> {
  final RemoteRepository _remoteRepository;
  List<CategoryEntity> categories = [];

  AdminCategoryBloc(this._remoteRepository) : super(const AdminCategoryState().inProgress()) {
    on<InitCategoriesEvent>(_initCategories);
    on<CreateNewCategoryEvent>(_createNewCategory);
    on<SaveCategoryEvent>(_saveCategory);
  }

  Future<void> _initCategories(AdminCategoryEvent event, Emitter<AdminCategoryState> emit) async {
    emit(state.inProgress());
    try {
      categories = await _remoteRepository.getCategoriesList();
      emit(state.categoriesLoaded(categories));
    } catch (e) {
      emit(state.failure());
    }
  }

  void _createNewCategory(AdminCategoryEvent event, Emitter<AdminCategoryState> emit) async {
    emit(state.createCategory());
  }

  Future<void> _saveCategory(SaveCategoryEvent event, Emitter<AdminCategoryState> emit) async {
    emit(state.inProgress());
    await _remoteRepository.createCategory(event.category);
    emit(const CreateCategoryState());
  }
}
