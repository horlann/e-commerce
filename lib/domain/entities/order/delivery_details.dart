import 'package:kurilki/data/models/order/delivery_details_table_model.dart';

class DeliveryDetails {
  final DeliveryType deliveryType;
  final String address;
  final String name;
  final String phone;

  const DeliveryDetails({
    required this.deliveryType,
    required this.address,
    required this.name,
    required this.phone,
  });

  DeliveryDetails copyWith({
    DeliveryType? deliveryType,
    String? address,
    String? name,
    String? phone,
  }) {
    return DeliveryDetails(
      deliveryType: deliveryType ?? this.deliveryType,
      address: address ?? this.address,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  factory DeliveryDetails.fromTableModel(DeliveryDetailsTableModel? model) => DeliveryDetails(
        deliveryType: model?.deliveryType ?? DeliveryType.undefined,
        address: model?.address ?? "",
        name: model?.name ?? "",
        phone: model?.phone ?? "",
      );
}

enum DeliveryType { pickUp, delivery, undefined }
