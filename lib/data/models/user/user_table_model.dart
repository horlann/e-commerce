import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';

part 'user_table_model.g.dart';

@JsonSerializable()
class UserTableModel {
  @JsonKey(name: FirestoreSchema.uuid)
  final String uuid;
  @JsonKey(name: FirestoreSchema.authId)
  final String authId;
  @JsonKey(name: FirestoreSchema.name)
  final String name;
  @JsonKey(name: FirestoreSchema.imageLink)
  final String imageLink;

  factory UserTableModel.fromJson(Map<String, dynamic> json) => _$UserTableModelFromJson(json);

  factory UserTableModel.fromEntity(UserEntity entity) =>
      UserTableModel(uuid: entity.uuid, authId: entity.authId, name: entity.name, imageLink: entity.imageLink);

  Json toJson() => _$UserTableModelToJson(this);

  const UserTableModel({
    required this.uuid,
    required this.authId,
    required this.name,
    required this.imageLink,
  });
}
