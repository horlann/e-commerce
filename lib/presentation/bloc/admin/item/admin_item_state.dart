import 'package:kurilki/domain/entities/items/item.dart';

class AdminItemState {
  const AdminItemState();

  AdminItemState init() {
    return const AdminItemState();
  }

  AdminItemState inProgress() {
    return const InProgressLoadingState();
  }

  AdminItemState failure() {
    return const AdminFailureState();
  }

  AdminItemState editItem(Item item) {
    return EditItemState(item);
  }

  AdminItemState saveItem() {
    return const SaveEditItemState();
  }

  AdminItemState itemsLoaded(List<Item> items) {
    return ItemsLoadedState(items);
  }
}

class InProgressLoadingState extends AdminItemState {
  const InProgressLoadingState();
}

class AdminFailureState extends AdminItemState {
  const AdminFailureState();
}

class EditItemState extends AdminItemState {
  const EditItemState(this.item);

  final Item item;
}

class SaveEditItemState extends AdminItemState {
  const SaveEditItemState();
}

class ItemsLoadedState extends AdminItemState {
  const ItemsLoadedState(this.items);

  final List<Item> items;
}
