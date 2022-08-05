import 'package:kurilki/domain/entities/category/category_entity.dart';

class AdminCategoryState {
  const AdminCategoryState();

  AdminCategoryState init() {
    return const AdminCategoryState();
  }

  AdminCategoryState inProgress() {
    return const InProgressLoadingState();
  }

  AdminCategoryState failure() {
    return const AdminCategoryState();
  }

  AdminCategoryState categoriesLoaded(List<CategoryEntity> categories) {
    return CategoriesLoadedState(categories);
  }

  AdminCategoryState createCategory() {
    return const CreateCategoryState();
  }
}

class InProgressLoadingState extends AdminCategoryState {
  const InProgressLoadingState();
}

class AdminFailureState extends AdminCategoryState {
  const AdminFailureState();
}

class CategoriesLoadedState extends AdminCategoryState {
  const CategoriesLoadedState(this.categories);

  final List<CategoryEntity> categories;
}

class CreateCategoryState extends AdminCategoryState {
  const CreateCategoryState();
}
