import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/data/models/items/item_settings_table_model.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/domain/entities/user/history_item.dart';
part 'history_item_table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HistoryItemTableModel {
  @JsonKey(name: FirestoreSchema.item)
  final ItemTableModel item;
  @JsonKey(name: FirestoreSchema.itemSettings)
  final ItemSettingsTableModel itemSettings;

  factory HistoryItemTableModel.fromJson(Map<String, dynamic> json) => _$HistoryItemTableModelFromJson(json);

  factory HistoryItemTableModel.fromEntity(HistoryItem entity) => HistoryItemTableModel(
        item: ItemTableModel.fromEntity(entity.item),
        itemSettings: ItemSettingsTableModel.fromEntity(entity.itemSettings),
      );

  Json toJson() => _$HistoryItemTableModelToJson(this);

  const HistoryItemTableModel({
    required this.item,
    required this.itemSettings,
  });

  HistoryItemTableModel copyWith({
    ItemTableModel? item,
    ItemSettingsTableModel? itemSettings,
  }) {
    return HistoryItemTableModel(
      item: item ?? this.item,
      itemSettings: itemSettings ?? this.itemSettings,
    );
  }
}
