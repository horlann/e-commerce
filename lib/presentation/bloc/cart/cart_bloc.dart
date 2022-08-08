import 'package:bloc/bloc.dart';
import 'package:kurilki/data/repositories/local_repository.dart';
import 'package:kurilki/data/repositories/ordering/ordering_remote_repository.dart';
import 'package:kurilki/data/repositories/user/user_remote_repository.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final OrderingRemoteRepository _orderingRemoteRepository;
  final UserRemoteRepository _userRemoteRepository;
  final LocalRepository _localRepository;

  CartBloc(this._localRepository, this._orderingRemoteRepository, this._userRemoteRepository)
      : super(const CartState().inProgress()) {
    on<InitCartEvent>(_init);
    on<AddToCartEvent>(_addToCart);
    on<ChangeItemCountEvent>(_changeItemCount);
    on<RemoveFromCartEvent>(_removeFromCartEvent);
    on<ConfirmOrderEvent>(_confirm);
  }

  List<CartItem> cartItems = [];

  int countOfItemsInCart(String uuid, AbstractItemSettings? settings) {
    int count = 0;
    for (CartItem e in cartItems) {
      if (e.item.uuid == uuid && (e.itemSettings.name == (settings?.name ?? "empty"))) {
        count = e.count;
      }
    }
    return count;
  }

  void _init(InitCartEvent event, Emitter<CartState> emit) async {
    cartItems = await _loadCachedCartItems();
    emit(state.cartLoadedState(cartItems));
  }

  Future<List<CartItem>> _loadCachedCartItems() async {
    //cartItems = await _localRepository.getCartCache();
    List<CartItem> cartItems = [];
    return cartItems;
  }

  Future<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    if (countOfItemsInCart(event.item.uuid, event.itemSettings) > 0) {
      final int index = cartItems.indexWhere((element) => element.item.uuid == event.item.uuid);
      cartItems.insert(
          index + 1, cartItems[index].copyWith(count: countOfItemsInCart(event.item.uuid, event.itemSettings) + 1));
      cartItems.removeAt(index);
    } else {
      cartItems.add(CartItem(item: event.item, count: 1, itemSettings: event.itemSettings));
    }
    emit(state.cartLoadedState(cartItems));
    print(cartItems);
    _localRepository.cacheCart(cartItems);
  }

  Future<void> _changeItemCount(ChangeItemCountEvent event, Emitter<CartState> emit) async {
    cartItems[event.index] = event.cartItem;
    _localRepository.cacheCart(cartItems);
    emit(CartLoadedState(cartItems));
  }

  Future<void> _removeFromCartEvent(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final int index = cartItems.indexWhere((element) => element.item.uuid == event.item.uuid);
    cartItems.removeAt(index);
    emit(state.cartLoadedState(cartItems));
  }

  Future<void> _confirm(ConfirmOrderEvent event, Emitter<CartState> emit) async {
    await _orderingRemoteRepository.createOrder(
      name: event.userData.name,
      items: cartItems,
      address: event.userData.address,
      deliveryType: event.userData.deliveryType,
      payType: event.userData.payType,
      phone: event.userData.phone,
    );

    cartItems.clear();
    emit(state.orderCreated());
    emit(state.cartLoadedState(cartItems));
    add(const InitCartEvent());
  }
}
