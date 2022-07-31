import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';

import 'item_settings_table_model.dart';

part 'snus_table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SnusTableModel extends ItemTableModel {
  SnusTableModel(
      {required super.uuid,
      required super.id,
      required super.name,
      required super.price,
      required super.oldPrice,
      required super.category,
      required super.imageLink,
      required super.tags,
      required super.isAvailable,
      required super.itemSettings,
      required this.strength});

  @JsonKey(name: FirestoreSchema.strength, defaultValue: 0)
  final int strength;

  factory SnusTableModel.fromJson(Map<String, dynamic> json) => _$SnusTableModelFromJson(json);

  @override
  Json toJson() => _$SnusTableModelToJson(this);
}
