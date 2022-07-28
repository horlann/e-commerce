import 'package:bloc/bloc.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/price_details.dart';
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
    on<ConfirmOrderEvent>(_confirm);
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
    cartItems = await _loadCachedCartItems();
    emit(state.cartLoadedState(cartItems));
  }

  Future<List<CartItem>> _loadCachedCartItems() async {
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
    emit(state.configureOrder());
  }

  void _confirm(ConfirmOrderEvent event, Emitter<CartState> emit) async {
    List<String> itemsId = cartItems.map((e) => e.item.uuid).toList();
    DeliveryType deliveryType;
    PayType payType;
    if (event.deliveryType == "Pick up") {
      deliveryType = DeliveryType.pickUp;
    } else if (event.deliveryType == "Delivery NovaPoshta") {
      deliveryType = DeliveryType.deliveryNovaPost;
    } else if (event.deliveryType == "Delivery UkrPoshta") {
      deliveryType = DeliveryType.deliveryUkrPost;
    } else {
      deliveryType = DeliveryType.none;
    }

    if (event.payType == "Bank transfer") {
      payType = PayType.bank;
    } else if (event.payType == "Сash on delivery") {
      payType = PayType.cashOnDelivery;
    } else {
      payType = PayType.none;
    }

    await _remoteRepository.createOrder(
      name: event.name,
      items: itemsId,
      address: event.address,
      deliveryType: deliveryType,
      payType: payType,
    );
    cartItems.clear();
    emit(state.orderCreated());
    emit(state.cartLoadedState(cartItems));
  }
}
