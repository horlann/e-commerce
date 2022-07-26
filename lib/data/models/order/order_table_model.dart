import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/data/models/order/delivery_details_table_model.dart';
import 'package:kurilki/domain/entities/order/order.dart';

import 'price_details_table_model.dart';

part 'order_table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderTableModel {
  @JsonKey(name: FirestoreSchema.uuid)
  final String uuid;
  @JsonKey(name: FirestoreSchema.number)
  final int number;
  @JsonKey(name: FirestoreSchema.userId)
  final String userId;
  @JsonKey(name: FirestoreSchema.itemsUuid)
  final List<String> itemsUuid;
  @JsonKey(name: FirestoreSchema.deliveryDetails)
  final DeliveryDetailsTableModel deliveryDetails;
  @JsonKey(name: FirestoreSchema.priceDetails)
  final PriceDetailsTableModel priceDetails;
  @JsonKey(name: FirestoreSchema.completedAt)
  final DateTime? completedAt;
  @JsonKey(name: FirestoreSchema.createdAt)
  final DateTime createdAt;
  @JsonKey(name: FirestoreSchema.orderStatus)
  final OrderStatus orderStatus;

  factory OrderTableModel.fromJson(Map<String, dynamic> json) => _$OrderTableModelFromJson(json);

  factory OrderTableModel.fromEntity(OrderEntity orderEntity) => OrderTableModel(
      uuid: orderEntity.uuid,
      number: orderEntity.number,
      userId: orderEntity.userId,
      itemsUuid: orderEntity.itemsUuid,
      deliveryDetails: DeliveryDetailsTableModel.fromEntity(orderEntity.deliveryDetails),
      priceDetails: PriceDetailsTableModel.fromEntity(orderEntity.priceDetails),
      completedAt: orderEntity.completedAt,
      createdAt: orderEntity.createdAt,
      orderStatus: orderEntity.orderStatus);

  Json toJson() => _$OrderTableModelToJson(this);

  const OrderTableModel({
    required this.uuid,
    required this.number,
    required this.userId,
    required this.itemsUuid,
    required this.deliveryDetails,
    required this.priceDetails,
    required this.completedAt,
    required this.createdAt,
    required this.orderStatus,
  });
}
