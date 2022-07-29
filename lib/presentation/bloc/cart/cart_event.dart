import 'package:kurilki/domain/entities/items/item.dart';

abstract class CartEvent {
  const CartEvent();
}

class InitCartEvent extends CartEvent {
  const InitCartEvent();
}

class AddToCartEvent extends CartEvent {
  const AddToCartEvent(this.item, this.count);

  final Item item;
  final int count;
}

class RemoveFromCartEvent extends CartEvent {
  const RemoveFromCartEvent(
    this.item,
  );

  final Item item;
}

class CheckoutEvent extends CartEvent {
  const CheckoutEvent();
}

class ConfirmOrderEvent extends CartEvent {
  const ConfirmOrderEvent({
    required this.name,
    required this.phone,
    required this.deliveryType,
    required this.payType,
    this.address = "",
  });

  final String name;
  final String phone;
  final String deliveryType;
  final String payType;
  final String address;
}
