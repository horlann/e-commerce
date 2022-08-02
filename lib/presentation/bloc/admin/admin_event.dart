import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';

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

class EditItemEvent extends AdminEvent {
  const EditItemEvent(this.item);

  final Item item;
}

class UpdateSnusItemEvent extends AdminEvent {
  const UpdateSnusItemEvent(this.item);

  final Snus item;
}

class UpdateDisposableItemEvent extends AdminEvent {
  const UpdateDisposableItemEvent(this.item);

  final DisposablePodEntity item;
}

class AddNewItemEvent extends AdminEvent {
  const AddNewItemEvent(this.item);

  final Item item;
}

class CreateNewCategoryEvent extends AdminEvent {
   const CreateNewCategoryEvent();
}

class AddNewCategoryEvent extends AdminEvent {
  const AddNewCategoryEvent(this.category);

  final String category;
}
