import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/data/models/order/order_table_model.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/domain/entities/order/price_details.dart';
import 'package:kurilki/domain/entities/order/user_details.dart';

@lazySingleton
class OrderingRemoteRepository {
  final RemoteDataSource _remoteDataSource;

  const OrderingRemoteRepository(this._remoteDataSource);

  Future<void> createOrder({
    required List<CartItem> items,
    required String name,
    required String address,
    required String phone,
    required DeliveryType deliveryType,
    required String payType,
  }) async {
    double price = 0;
    for (var item in items) {
      price += (item.count * item.item.price);
    }
    OrderEntity order = OrderEntity(
      items: items,
      user: UserDetails(
        name: name,
        number: phone,
        userId: (await _userId),
      ),
      number: (await _lastOrderNumber),
      deliveryDetails: DeliveryDetails(
        address: address,
        deliveryType: deliveryType,
        name: name,
        phone: phone,
      ),
      priceDetails: PriceDetails(
        totalPrice: price,
        itemsPrice: price,
        fullPrice: price,
        deliveryPrice: 20,
        type: payType,
      ),
    );
    await _remoteDataSource.createOrder(order);
  }

  Future<int> get _lastOrderNumber async {
    int number = 1;

    try {
      OrderTableModel order = await _remoteDataSource.lastOrder;
      number = order.number;
      return ++number;
    } catch (e) {
      return 1;
    }
  }

  Future<String> get _userId async {
    try {
      User user = await _remoteDataSource.userFromGoogleAuth;
      return user.uid;
    } on Exception catch (e) {
      if (e == Exception("User is not authorized")) {
        return "User is not authorized";
      }
    }
    return "";
  }
}
