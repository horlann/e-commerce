import 'package:kurilki/domain/entities/item.dart';

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
