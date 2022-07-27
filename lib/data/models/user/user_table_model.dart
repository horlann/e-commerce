import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/account_firestore_schema.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';

part 'user_table_model.g.dart';

@JsonSerializable()
class UserTableModel {
  @JsonKey(name: FirestoreSchema.uuid)
  final String uuid;
  @JsonKey(name: FirestoreSchema.name)
  final String name;
  @JsonKey(name: FirestoreSchema.imageLink)
  final String imageLink;

  factory UserTableModel.fromJson(Map<String, dynamic> json) => _$UserTableModelFromJson(json);

  Json toJson() => _$UserTableModelToJson(this);

  factory UserTableModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserTableModel(
      uuid: documentSnapshot.get(AccountFirestoreSchema.uuid),
      name: documentSnapshot.get(AccountFirestoreSchema.name),
      imageLink: documentSnapshot.get(AccountFirestoreSchema.imageLink),
    );
  }

  const UserTableModel({
    required this.uuid,
    required this.name,
    required this.imageLink,
  });
}
