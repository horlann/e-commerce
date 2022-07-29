import 'package:firebase_auth/firebase_auth.dart';
import 'package:kurilki/data/models/order/order_table_model.dart';
import 'package:kurilki/domain/entities/order/user_details.dart';
import 'package:kurilki/presentation/bloc/cart/cart_item.dart';
import 'package:uuid/uuid.dart';

import 'delivery_details.dart';
import 'price_details.dart';

class OrderEntity {
  final String uuid;
  final UserDetails user;
  final int number;
  final List<CartItem> items;
  final DeliveryDetails deliveryDetails;
  final PriceDetails priceDetails;
  final DateTime? completedAt;
  final DateTime createdAt;
  final OrderStatus orderStatus;

  OrderEntity({
    String? uuid,
    DateTime? createdAt,
    OrderStatus? orderStatus,
    required this.user,
    required this.number,
    required this.items,
    required this.deliveryDetails,
    required this.priceDetails,
    this.completedAt,
  })  : uuid = uuid ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        orderStatus = orderStatus ?? OrderStatus.created;

  OrderEntity copyWith({
    String? uuid,
    UserDetails? user,
    int? number,
    List<CartItem>? items,
    DeliveryDetails? deliveryDetails,
    PriceDetails? priceDetails,
    DateTime? createDate,
    DateTime? completeDate,
    OrderStatus? status,
  }) {
    return OrderEntity(
      uuid: uuid ?? this.uuid,
      user: user ?? this.user,
      number: number ?? this.number,
      items: items ?? this.items,
      deliveryDetails: deliveryDetails ?? this.deliveryDetails,
      priceDetails: priceDetails ?? this.priceDetails,
      completedAt: createDate ?? completedAt,
      createdAt: completeDate ?? createdAt,
      orderStatus: status ?? orderStatus,
    );
  }

  factory OrderEntity.fromTableModel(OrderTableModel model, List<CartItem> items) => OrderEntity(
      uuid: model.uuid,
      user: UserDetails.fromTableModel(model.user),
      number: model.number,
      items: items,
      deliveryDetails: DeliveryDetails.fromTableModel(model.deliveryDetails),
      priceDetails: PriceDetails.fromTableModel(model.priceDetails),
      completedAt: model.completedAt,
      createdAt: model.createdAt,
      orderStatus: model.orderStatus);
}

enum OrderStatus { created, cancelled, completed, inProgress }
