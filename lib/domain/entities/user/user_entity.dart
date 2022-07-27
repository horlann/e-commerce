import 'package:kurilki/data/models/user/user_table_model.dart';
import 'package:uuid/uuid.dart';

class UserEntity {
  final String uuid;
  final String authId;
  final String name;
  final String imageLink;

  UserEntity({
    String? uuid,
    required this.authId,
    required this.name,
    required this.imageLink,
  }) : uuid = uuid ?? const Uuid().v4();

  UserEntity copyWith({
    String? uuid,
    String? authId,
    String? name,
    String? imageLink,
  }) {
    return UserEntity(
      uuid: uuid ?? this.uuid,
      authId: authId ?? this.authId,
      name: name ?? this.name,
      imageLink: imageLink ?? this.imageLink,
    );
  }

  factory UserEntity.fromTableModel(UserTableModel model) =>
      UserEntity(uuid: model.uuid, authId: model.authId, name: model.name, imageLink: model.imageLink);

  @override
  String toString() => 'UserEntity(uuid: $uuid,authId: $authId name: $name, imageLink: $imageLink)';
}
