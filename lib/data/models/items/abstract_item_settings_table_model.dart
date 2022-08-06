import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/data/models/items/item_settings_table_model.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';

part 'abstract_item_settings_table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AbstractItemsSettingsTableModel {
  @JsonKey(name: FirestoreSchema.name, defaultValue: 'error')
  final String name;
  @JsonKey(name: FirestoreSchema.type, defaultValue: ItemSettingsType.empty)
  final ItemSettingsType type;

  const AbstractItemsSettingsTableModel({
    required this.name,
    required this.type,
  });

  factory AbstractItemsSettingsTableModel.fromJson(Map<String, dynamic> json) {
    AbstractItemsSettingsTableModel model = _$AbstractItemsSettingsTableModelFromJson(json);
    if (model.type == ItemSettingsType.filled) {
      return ItemSettingsTableModel.fromJson(json);
    } else {
      return _$AbstractItemsSettingsTableModelFromJson(json);
    }
  }

  Json toJson() {
    return _$AbstractItemsSettingsTableModelToJson(this);
  }

  factory AbstractItemsSettingsTableModel.fromEntity(AbstractItemSettings itemSettings) {
    if (itemSettings.type == ItemSettingsType.filled) {
      return ItemSettingsTableModel.fromEntity(itemSettings as ItemSettings);
    } else {
      return AbstractItemsSettingsTableModel(name: itemSettings.name, type: itemSettings.type);
    }
  }
}
