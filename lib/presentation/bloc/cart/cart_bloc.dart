import 'package:bloc/bloc.dart';
import 'package:kurilki/data/repositories/local_repository.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
import 'package:kurilki/main.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final RemoteRepository _remoteRepository;
  final LocalRepository _localRepository;

  CartBloc(this._remoteRepository, this._localRepository) : super(const CartState().inProgress()) {
    on<InitCartEvent>(_init);
    on<AddToCartEvent>(_addToCart);
    on<RemoveFromCartEvent>(_removeFromCartEvent);
    on<ConfirmOrderEvent>(_confirm);
    on<LoadDataEvent>(_loadData);
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
      cartItems.add(CartItem(item: event.item, count: 1, itemSettings: event.itemSettings));
    }
    emit(state.cartLoadedState(cartItems));
    _localRepository.cacheCart(cartItems);
  }

  Future<void> _removeFromCartEvent(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final int index = cartItems.indexWhere((element) => element.item.uuid == event.item.uuid);
    cartItems.removeAt(index);
    emit(state.cartLoadedState(cartItems));
  }

  Future<void> _loadData(LoadDataEvent event, Emitter<CartState> emit) async {
    emit(state.inProgress());
    try {
      UserEntity user = await _remoteRepository.getAccountEntity();
      emit(state.userDataLoaded(user));
    } catch (e) {
      emit(state.userDataLoaded(null));
    }
  }

  Future<void> _confirm(ConfirmOrderEvent event, Emitter<CartState> emit) async {
    DeliveryType deliveryType;
    if (event.deliveryType == "Pick up") {
      deliveryType = DeliveryType.pickUp;
    } else if (event.deliveryType == "Delivery NovaPoshta") {
      deliveryType = DeliveryType.deliveryNovaPost;
    } else {
      deliveryType = DeliveryType.undefined;
    }

    await _remoteRepository.createOrder(
      name: event.name,
      items: cartItems,
      address: event.address,
      deliveryType: deliveryType,
      payType: event.payType,
      phone: event.phone,
    );

    try {
      UserEntity userEntity = await _remoteRepository.getAccountEntity();
      userEntity = userEntity.copyWith(
          deliveryDetails: DeliveryDetails(
              deliveryType: deliveryType, address: event.address, name: event.name, phone: event.phone));
      _remoteRepository.setAccountEntity(userEntity);
    } catch (e) {
      logger.i(e);
    }
    cartItems.clear();
    emit(state.orderCreated());
    emit(state.cartLoadedState(cartItems));
    add(const InitCartEvent());
  }
}
