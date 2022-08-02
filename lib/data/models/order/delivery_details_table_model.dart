import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';

part 'delivery_details_table_model.g.dart';

@JsonSerializable()
class DeliveryDetailsTableModel {
  @JsonKey(name: FirestoreSchema.deliveryType, defaultValue: DeliveryType.undefined)
  final DeliveryType deliveryType;
  @JsonKey(name: FirestoreSchema.address, defaultValue: '')
  final String address;
  @JsonKey(name: FirestoreSchema.name, defaultValue: '')
  final String? name;
  @JsonKey(name: FirestoreSchema.phone, defaultValue: '')
  final String? phone;

  factory DeliveryDetailsTableModel.fromJson(Map<String, dynamic> json) => _$DeliveryDetailsTableModelFromJson(json);

  factory DeliveryDetailsTableModel.fromEntity(DeliveryDetails? deliveryDetails) => DeliveryDetailsTableModel(
        deliveryType: deliveryDetails?.deliveryType ?? DeliveryType.undefined,
        address: deliveryDetails?.address ?? "",
        name: deliveryDetails?.name ?? "",
        phone: deliveryDetails?.phone ?? "",
      );

  Map<String, dynamic> toJson() => _$DeliveryDetailsTableModelToJson(this);

  const DeliveryDetailsTableModel({
    required this.deliveryType,
    required this.address,
    required this.name,
    required this.phone,
  });
}
