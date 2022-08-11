import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/price_details.dart';

class UserData {
  final String name;
  final String phone;
  final DeliveryType deliveryType;

  final String address;

  UserData({
    required this.name,
    required this.phone,
    required this.deliveryType,
    this.address = "",
  });

  UserData copyWith({
    String? name,
    String? phone,
    DeliveryType? deliveryType,
    String? payType,
    String? address,
    PriceDetails? priceDetails,
  }) {
    return UserData(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      deliveryType: deliveryType ?? this.deliveryType,
      address: address ?? this.address,
    );
  }
}
