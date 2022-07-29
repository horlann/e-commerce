import 'package:kurilki/domain/entities/items/item.dart';

abstract class AdminEvent {
  const AdminEvent();
}

class InitCategoriesEvent extends AdminEvent {
  const InitCategoriesEvent();
}

class InitOrdersEvent extends AdminEvent {
  const InitOrdersEvent();
}

class InitProductsEvent extends AdminEvent {
  const InitProductsEvent();
}

class AddNewItemEvent extends AdminEvent {
  const AddNewItemEvent(this.item);

  final Item item;
}

class AddNewCategoryEvent extends AdminEvent {
  const AddNewCategoryEvent(this.category);

  final String category;
}
