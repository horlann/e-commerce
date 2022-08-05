abstract class AdminCategoryEvent {
  const AdminCategoryEvent();
}

class InitCategoriesEvent extends AdminCategoryEvent {
  const InitCategoriesEvent();
}

class CreateNewCategoryEvent extends AdminCategoryEvent {
  const CreateNewCategoryEvent();
}

class SaveCategoryEvent extends AdminCategoryEvent {
  const SaveCategoryEvent(this.category);

  final String category;
}
