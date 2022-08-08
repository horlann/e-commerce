import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';

class CartState {
  const CartState();

  CartState init() {
    return const CartState();
  }

  CartState clone() {
    return const CartState();
  }

  CartState inProgress() {
    return const InProgressCartState();
  }

  CartState orderCreated() {
    return const OrderCreated();
  }

  CartState cartLoadedState(List<CartItem> cartItems) {
    return CartLoadedState(cartItems);
  }

  CartState configureOrder() {
    return const ConfigureOrderState();
  }
}

class InProgressCartState extends CartState {
  const InProgressCartState();
}

class CartLoadedState extends CartState {
  const CartLoadedState(this.cartItems);

  final List<CartItem> cartItems;
}

class CartFailureState extends CartState {
  const CartFailureState();
}

class OrderCreated extends CartState {
  const OrderCreated();
}

class ConfigureOrderState extends CartState {
  const ConfigureOrderState();
}
