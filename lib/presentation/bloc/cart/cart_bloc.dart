import 'package:bloc/bloc.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/presentation/bloc/cart/cart_item.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final RemoteRepository _remoteRepository;

  CartBloc(this._remoteRepository) : super(const CartState().inProgress()) {
    on<InitCartEvent>(_init);
    on<AddToCartEvent>(_addToCart);
    on<RemoveFromCartEvent>(_removeFromCartEvent);
    on<CheckoutEvent>(_checkout);
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

  Future<void> _removeFromCartEvent(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final int index = cartItems.indexWhere((element) => element.item.uuid == event.item.uuid);
    cartItems.removeAt(index);
    emit(state.cartLoadedState(cartItems));
  }

  Future<void> _checkout(CheckoutEvent event, Emitter<CartState> emit) async {
    List<String> itemsId = cartItems.map((e) => e.item.uuid).toList();
    await _remoteRepository.createOrder(items: itemsId);
    cartItems.clear();
    emit(state.orderCreated());
    emit(state.cartLoadedState(cartItems));
  }
}
