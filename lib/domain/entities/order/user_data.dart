import 'package:kurilki/domain/entities/order/delivery_details.dart';

class UserData {
  final String name;
  final String phone;
  final DeliveryType deliveryType;
  final String payType;
  final String address;

  UserData({
    required this.name,
    required this.phone,
    required this.deliveryType,
    required this.payType,
    this.address = "",
  });

  UserData copyWith({
    String? name,
    String? phone,
    DeliveryType? deliveryType,
    String? payType,
    String? address,
  }) {
    return UserData(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      deliveryType: deliveryType ?? this.deliveryType,
      payType: payType ?? this.payType,
      address: address ?? this.address,
    );
  }
}
