import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';

import 'abstract_item_settings_table_model.dart';

part 'item_settings_table_model.g.dart';

@JsonSerializable()
class ItemSettingsTableModel extends AbstractItemsSettingsTableModel {
  @JsonKey(name: FirestoreSchema.uuid)
  final String uuid;
  @JsonKey(name: FirestoreSchema.imageLink, defaultValue: '')
  final String imageLink;
  @JsonKey(name: FirestoreSchema.isAvailable, defaultValue: false)
  final bool isAvailable;
  @JsonKey(name: FirestoreSchema.count, defaultValue: 0)
  final int count;

  const ItemSettingsTableModel({
    required this.uuid,
    required this.imageLink,
    required this.isAvailable,
    required this.count,
    required super.name,
    required super.type,
  });

  factory ItemSettingsTableModel.fromJson(Map<String, dynamic> json) => _$ItemSettingsTableModelFromJson(json);

  @override
  Json toJson() => _$ItemSettingsTableModelToJson(this);

  factory ItemSettingsTableModel.fromEntity(ItemSettings itemSettings) => ItemSettingsTableModel(
      uuid: itemSettings.uuid,
      imageLink: itemSettings.imageLink,
      count: itemSettings.count,
      isAvailable: itemSettings.isAvailable,
      name: itemSettings.name,
      type: itemSettings.type);
}
