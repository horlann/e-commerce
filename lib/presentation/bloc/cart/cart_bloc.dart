import 'package:bloc/bloc.dart';
import 'package:kurilki/common/const/const.dart';
import 'package:kurilki/data/repositories/local_repository.dart';
import 'package:kurilki/data/repositories/ordering/ordering_remote_repository.dart';
import 'package:kurilki/data/repositories/user/user_remote_repository.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/price_details.dart';
import 'package:kurilki/domain/entities/user/history_item.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';

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
    on<DeliveryChangedEvent>(_deliveryChanged);
  }

  List<CartItem> cartItems = [];
  PriceDetails priceDetails = PriceDetails(deliveryPrice: 0, itemsPrice: 0, totalPrice: 0);

  int _countOfItemsInCart(String uuid, ItemSettings? settings) {
    int count = 0;
    for (CartItem e in cartItems) {
      if (e.item.uuid == uuid && (e.itemSettings.name == (settings?.name ?? Const.empty))) {
        count = e.count;
      }
    }
    return count;
  }

  void _calculatePrice() {
    double itemPrice = 0;
    for (CartItem element in cartItems) {
      itemPrice += element.count * element.item.price;
    }
    priceDetails = priceDetails.copyWith(itemsPrice: itemPrice);
    priceDetails =
        priceDetails.copyWith(totalPrice: priceDetails.itemsPrice + priceDetails.deliveryPrice - priceDetails.coupon);
  }

  void _init(InitCartEvent event, Emitter<CartState> emit) async {
    cartItems = await _loadCachedCartItems();
    emit(state.cartLoadedState(cartItems));
  }

  Future<List<CartItem>> _loadCachedCartItems() async {
    return await _localRepository.getCartCache();
  }

  Future<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    if (_countOfItemsInCart(event.item.uuid, event.itemSettings) > 0) {
      final int index = cartItems.indexWhere((element) {
        print(element.itemSettings.toString());
        print(element.itemSettings == event.itemSettings);
        return element.itemSettings == event.itemSettings;
      });
      cartItems[index] = cartItems[index].copyWith(count: (cartItems[index].count + event.count));
    } else {
      cartItems.add(CartItem(item: event.item, count: event.count, itemSettings: event.itemSettings));
    }
    _calculatePrice();
    await _localRepository.cacheCart(cartItems);
    emit(state.cartLoadedState(cartItems));
  }

  Future<void> _changeItemCount(ChangeItemCountEvent event, Emitter<CartState> emit) async {
    cartItems[event.index] = event.cartItem;
    _calculatePrice();
    await _localRepository.cacheCart(cartItems);
    emit(CartLoadedState(cartItems));
  }

  Future<void> _removeFromCartEvent(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final int index = cartItems.indexWhere((element) => element.item.uuid == event.item.uuid);
    _calculatePrice();
    cartItems.removeAt(index);
    emit(state.cartLoadedState(cartItems));
  }

  void _deliveryChanged(DeliveryChangedEvent event, Emitter<CartState> emit) {
    if (event.deliveryType == DeliveryType.pickUp) {
      priceDetails = priceDetails.copyWith(deliveryPrice: 0);
    } else {
      priceDetails = priceDetails.copyWith(deliveryPrice: Const.deliveryPrice);
    }
    priceDetails =
        priceDetails.copyWith(totalPrice: priceDetails.itemsPrice + priceDetails.deliveryPrice - priceDetails.coupon);
  }

  Future<void> _confirm(ConfirmOrderEvent event, Emitter<CartState> emit) async {
    _calculatePrice();
    if (event.userData.deliveryType != DeliveryType.pickUp) {
      priceDetails = priceDetails.copyWith(deliveryPrice: Const.deliveryPrice);
      priceDetails =
          priceDetails.copyWith(totalPrice: priceDetails.itemsPrice + priceDetails.deliveryPrice - priceDetails.coupon);
    }
    await _orderingRemoteRepository.createOrder(
      name: event.userData.name,
      items: cartItems,
      address: event.userData.address,
      deliveryType: event.userData.deliveryType,
      phone: event.userData.phone,
      priceDetails: priceDetails,
    );
    //todo: change bloc
    UserEntity userEntity = await _userRemoteRepository.getAccountEntity();
    final List<HistoryItem> historyItems = [];
    for (CartItem cartItem in cartItems) {
      for (int i = 1; i <= cartItem.count; i++) {
        historyItems.add(HistoryItem(
          item: cartItem.item,
          itemSettings: cartItem.itemSettings,
        ));
      }
    }
    userEntity = userEntity.copyWith(items: userEntity.items + historyItems);
    await _userRemoteRepository.setAccountEntity(userEntity);

    cartItems.clear();
    emit(state.orderCreated());
    emit(state.cartLoadedState(cartItems));
    add(const InitCartEvent());
  }
}
