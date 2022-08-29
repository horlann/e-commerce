import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/user_data.dart';

abstract class CartEvent {
  const CartEvent();
}

class InitCartEvent extends CartEvent {
  const InitCartEvent();
}

class AddToCartEvent extends CartEvent {
  const AddToCartEvent(this.item, this.count, this.itemSettings);

  final Item item;
  final ItemSettings itemSettings;
  final int count;
}

class ChangeItemCountEvent extends CartEvent {
  const ChangeItemCountEvent(this.cartItem, this.index);

  final CartItem cartItem;
  final int index;
}

class RemoveFromCartEvent extends CartEvent {
  const RemoveFromCartEvent(
    this.item,
  );

  final Item item;
}

class ConfirmOrderEvent extends CartEvent {
  const ConfirmOrderEvent({required this.userData});

  final UserData userData;
}

class DeliveryChangedEvent extends CartEvent {
  const DeliveryChangedEvent({required this.deliveryType});

  final DeliveryType deliveryType;
}
