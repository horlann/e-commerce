import 'package:kurilki/domain/entities/item.dart';

abstract class AdminEvent {
  const AdminEvent();
}

class InitDataEvent extends AdminEvent {
  const InitDataEvent();
}

class AddNewItemEvent extends AdminEvent {
  const AddNewItemEvent(this.item);

  final Item item;
}

class AddNewCategoryEvent extends AdminEvent {
  const AddNewCategoryEvent(this.category);

  final String category;
}
