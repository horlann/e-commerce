import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';

abstract class AdminItemEvent {
  const AdminItemEvent();
}

class InitItemsEvent extends AdminItemEvent {
  const InitItemsEvent();
}

class EditItemEvent extends AdminItemEvent {
  const EditItemEvent(this.item);

  final Item item;
}

class CreateItemEvent extends AdminItemEvent {
  const CreateItemEvent(this.item);

  final Item item;
}

class UpdateDisposableItemEvent extends AdminItemEvent {
  const UpdateDisposableItemEvent(this.item);

  final DisposablePodEntity item;
}

class UpdateSnusItemEvent extends AdminItemEvent {
  const UpdateSnusItemEvent(this.item);

  final Snus item;
}
