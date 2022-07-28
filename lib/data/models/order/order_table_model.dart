import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/data/models/order/cart_item_table_model.dart';
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
  @JsonKey(name: FirestoreSchema.items)
  final List<CartItemTableModel> items;
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
      items: orderEntity.items.map((e) => CartItemTableModel.fromEntity(e)).toList(),
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
    required this.items,
    required this.deliveryDetails,
    required this.priceDetails,
    this.completedAt,
    required this.createdAt,
    required this.orderStatus,
  });

  OrderTableModel copyWith({
    String? uuid,
    int? number,
    String? userId,
    List<String>? itemsUuid,
    List<CartItemTableModel>? items,
    DeliveryDetailsTableModel? deliveryDetails,
    PriceDetailsTableModel? priceDetails,
    DateTime? completedAt,
    DateTime? createdAt,
    OrderStatus? orderStatus,
  }) {
    return OrderTableModel(
      uuid: uuid ?? this.uuid,
      number: number ?? this.number,
      userId: userId ?? this.userId,
      itemsUuid: itemsUuid ?? this.itemsUuid,
      items: items ?? this.items,
      deliveryDetails: deliveryDetails ?? this.deliveryDetails,
      priceDetails: priceDetails ?? this.priceDetails,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }
}
