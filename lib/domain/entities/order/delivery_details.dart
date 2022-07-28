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
}

enum DeliveryType { pickUp, deliveryNovaPost, deliveryUkrPost, none }
