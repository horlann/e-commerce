import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/data/models/items/item_settings_table_model.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/domain/entities/user/history_item.dart';
part 'history_item_table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HistoryItemTableModel {
  @JsonKey(name: FirestoreSchema.item)
  final ItemTableModel item;
  @JsonKey(name: FirestoreSchema.itemSettings)
  final ItemSettingsTableModel itemSettings;
  @JsonKey(name: FirestoreSchema.completedAt)
  final DateTime? completedAt;
  @JsonKey(name: FirestoreSchema.createdAt)
  final DateTime createdAt;
  @JsonKey(name: FirestoreSchema.orderStatus)
  final OrderStatus orderStatus;

  factory HistoryItemTableModel.fromJson(Map<String, dynamic> json) => _$HistoryItemTableModelFromJson(json);

  factory HistoryItemTableModel.fromEntity(HistoryItem entity) => HistoryItemTableModel(
        item: ItemTableModel.fromEntity(entity.item),
        itemSettings: ItemSettingsTableModel.fromEntity(entity.itemSettings),
        orderStatus: entity.orderStatus,
        createdAt: entity.createdAt,
        completedAt: entity.completedAt,
      );

  Json toJson() => _$HistoryItemTableModelToJson(this);

  const HistoryItemTableModel({
    required this.item,
    required this.itemSettings,
    required this.createdAt,
    required this.orderStatus,
    this.completedAt,
  });
}
