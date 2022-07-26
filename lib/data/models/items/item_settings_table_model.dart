import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';

part 'item_settings_table_model.g.dart';

@JsonSerializable()
class ItemSettingsTableModel {
  @JsonKey(name: FirestoreSchema.name, defaultValue: 'error')
  final String name;
  @JsonKey(name: FirestoreSchema.uuid)
  final String uuid;
  @JsonKey(name: FirestoreSchema.imageLink, defaultValue: '')
  final String imageLink;
  @JsonKey(name: FirestoreSchema.isAvailable, defaultValue: false)
  final bool isAvailable;
  @JsonKey(name: FirestoreSchema.count, defaultValue: 0)
  final int count;
  @JsonKey(name: FirestoreSchema.isPopular, defaultValue: false)
  final bool isPopular;

  const ItemSettingsTableModel({
    required this.uuid,
    required this.imageLink,
    required this.isAvailable,
    required this.count,
    required this.name,
    required this.isPopular,
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
        isPopular: itemSettings.isPopular,
      );
}
