import 'package:bloc/bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_item.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState().inProgress()) {
    on<InitCartEvent>(_init);
    on<AddToCartEvent>(_addToCart);
  }

  List<CartItem> cartItems = [];

  int countOfItemsInCart(String uuid) {
    int count = 0;
    for (CartItem e in cartItems) {
      if (e.item.uuid == uuid) {
        count = e.count;
      }
    }
    return count;
  }

  void _init(InitCartEvent event, Emitter<CartState> emit) async {
    cartItems = await _loadCashedCartItems();
    emit(state.cartLoadedState(cartItems));
  }

  Future<List<CartItem>> _loadCashedCartItems() async {
    List<CartItem> cartItems = [];
    return cartItems;
  }

  Future<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    if (countOfItemsInCart(event.item.uuid) > 0) {
      final int index = cartItems.indexWhere((element) => element.item.uuid == event.item.uuid);
      cartItems.insert(index + 1, cartItems[index].copyWith(count: countOfItemsInCart(event.item.uuid) + 1));
      cartItems.removeAt(index);
    } else {
      cartItems.add(CartItem(item: event.item, count: 1));
    }
    emit(state.cartLoadedState(cartItems));
  }
}
