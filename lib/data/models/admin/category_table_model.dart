import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/admin_firestore_schema.dart';

part 'category_table_model.g.dart';

@JsonSerializable()
class CategoryTableModel {
  @JsonKey(name: AdminFirestoreSchema.name)
  final String name;
  @JsonKey(name: AdminFirestoreSchema.id, defaultValue: -1)
  final int id;
  @JsonKey(name: AdminFirestoreSchema.imageLink, defaultValue: '')
  final String imageLink;
  @JsonKey(name: AdminFirestoreSchema.uuid, defaultValue: '')
  final String uuid;

  const CategoryTableModel({
    required this.name,
    required this.id,
    required this.imageLink,
    required this.uuid,
  });

  factory CategoryTableModel.fromJson(Map<String, dynamic> json) => _$CategoryTableModelFromJson(json);

  Json toJson() => _$CategoryTableModelToJson(this);
}
