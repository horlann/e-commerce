import 'package:kurilki/data/models/user/user_table_model.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/user/history_item.dart';
import 'package:uuid/uuid.dart';

class UserEntity {
  final String uuid;
  final String authId;
  final String name;
  final String imageLink;
  final DeliveryDetails deliveryDetails;
  final List<HistoryItem> items;

  UserEntity({
    String? uuid,
    required this.authId,
    required this.name,
    required this.imageLink,
    required this.deliveryDetails,
    required this.items,
  }) : uuid = uuid ?? const Uuid().v4();

  UserEntity copyWith({
    String? uuid,
    String? authId,
    String? name,
    String? imageLink,
    DeliveryDetails? deliveryDetails,
    List<HistoryItem>? items,
  }) {
    return UserEntity(
      uuid: uuid ?? this.uuid,
      authId: authId ?? this.authId,
      name: name ?? this.name,
      imageLink: imageLink ?? this.imageLink,
      deliveryDetails: deliveryDetails ?? this.deliveryDetails,
      items: items ?? this.items,
    );
  }

  factory UserEntity.fromTableModel(UserTableModel model) => UserEntity(
        uuid: model.uuid,
        authId: model.authId,
        name: model.name,
        imageLink: model.imageLink,
        deliveryDetails: DeliveryDetails.fromTableModel(model.deliveryDetails),
        items: model.items.map((e) => HistoryItem.fromTableModel(e)).toList(),
      );

  @override
  String toString() => 'UserEntity(uuid: $uuid,authId: $authId name: $name, imageLink: $imageLink)';
}
