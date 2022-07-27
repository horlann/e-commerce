import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/domain/entities/order/price_details.dart';

part 'price_details_table_model.g.dart';

@JsonSerializable()
class PriceDetailsTableModel {
  @JsonKey(name: FirestoreSchema.fullPrice)
  final double fullPrice;
  @JsonKey(name: FirestoreSchema.deliveryPrice)
  final double deliveryPrice;
  @JsonKey(name: FirestoreSchema.coupon)
  final double coupon;
  @JsonKey(name: FirestoreSchema.salePercent)
  final double salePercent;
  @JsonKey(name: FirestoreSchema.totalPrice)
  final double totalPrice;
  @JsonKey(name: FirestoreSchema.itemsPrice)
  final double itemsPrice;

  const PriceDetailsTableModel({
    required this.fullPrice,
    required this.deliveryPrice,
    required this.coupon,
    required this.salePercent,
    required this.totalPrice,
    required this.itemsPrice,
  });

  factory PriceDetailsTableModel.fromJson(Map<String, dynamic> json) => _$PriceDetailsTableModelFromJson(json);

  factory PriceDetailsTableModel.fromEntity(PriceDetails priceDetails) => PriceDetailsTableModel(
      coupon: priceDetails.coupon,
      deliveryPrice: priceDetails.deliveryPrice,
      fullPrice: priceDetails.fullPrice,
      itemsPrice: priceDetails.itemsPrice,
      salePercent: priceDetails.salePercent,
      totalPrice: priceDetails.totalPrice);

  Map<String, dynamic> toJson() => _$PriceDetailsTableModelToJson(this);
}
