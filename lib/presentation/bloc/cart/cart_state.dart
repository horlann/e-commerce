import 'package:kurilki/presentation/bloc/cart/cart_item.dart';

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

  CartState cartLoadedState(List<CartItem> cartItems) {
    return CartLoadedState(cartItems);
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