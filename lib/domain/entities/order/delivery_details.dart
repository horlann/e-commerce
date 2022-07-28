import 'package:kurilki/data/models/order/delivery_details_table_model.dart';

class DeliveryDetails {
  final DeliveryType deliveryType;
  final String address;

  const DeliveryDetails({
    required this.deliveryType,
    required this.address,
  });

  DeliveryDetails copyWith({
    DeliveryType? deliveryType,
    String? address,
  }) {
    return DeliveryDetails(
      deliveryType: deliveryType ?? this.deliveryType,
      address: address ?? this.address,
    );
  }

  factory DeliveryDetails.fromTableModel(DeliveryDetailsTableModel model) =>
      DeliveryDetails(deliveryType: model.deliveryType, address: model.address);
}

enum DeliveryType { pickUp, deliveryNovaPost, deliveryUkrPost, none }
