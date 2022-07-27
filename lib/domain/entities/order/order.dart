import 'package:uuid/uuid.dart';

import 'delivery_details.dart';
import 'price_details.dart';

class OrderEntity {
  final String uuid;
  final int number;
  final String userId;
  final List<String> itemsUuid;
  final DeliveryDetails deliveryDetails;
  final PriceDetails priceDetails;
  final DateTime? completedAt;
  final DateTime createdAt;
  final OrderStatus orderStatus;

  OrderEntity({
    String? uuid,
    DateTime? createdAt,
    OrderStatus? orderStatus,
    required this.number,
    required this.userId,
    required this.itemsUuid,
    required this.deliveryDetails,
    required this.priceDetails,
    this.completedAt,
  })  : uuid = uuid ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        orderStatus = orderStatus ?? OrderStatus.created;

  OrderEntity copyWith({
    String? uuid,
    int? number,
    String? userId,
    List<String>? itemsUuid,
    DeliveryDetails? deliveryDetails,
    PriceDetails? priceDetails,
    DateTime? createDate,
    DateTime? completeDate,
    OrderStatus? status,
  }) {
    return OrderEntity(
      uuid: uuid ?? this.uuid,
      number: number ?? this.number,
      userId: userId ?? this.userId,
      itemsUuid: itemsUuid ?? this.itemsUuid,
      deliveryDetails: deliveryDetails ?? this.deliveryDetails,
      priceDetails: priceDetails ?? this.priceDetails,
      completedAt: createDate ?? completedAt,
      createdAt: completeDate ?? createdAt,
      orderStatus: status ?? orderStatus,
    );
  }
}

enum OrderStatus { created, cancelled, completed, inProgress }
