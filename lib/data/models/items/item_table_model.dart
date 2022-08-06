import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/data/models/items/disposable_pod_table_model.dart';
import 'package:kurilki/data/models/items/snus_table_model.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';

import 'item_settings_table_model.dart';

part 'item_table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemTableModel {
  @JsonKey(name: FirestoreSchema.uuid)
  final String uuid;
  @JsonKey(name: FirestoreSchema.id, defaultValue: '-1')
  final String id;
  @JsonKey(name: FirestoreSchema.name, defaultValue: '')
  final String name;
  @JsonKey(name: FirestoreSchema.price, defaultValue: 0)
  final double price;
  @JsonKey(name: FirestoreSchema.oldPrice, defaultValue: 0)
  final double oldPrice;
  @JsonKey(name: FirestoreSchema.categoryName, defaultValue: 'unidentified')
  final String category;
  @JsonKey(name: FirestoreSchema.imageLink, defaultValue: '')
  final String imageLink;
  @JsonKey(name: FirestoreSchema.tags, defaultValue: [])
  final List<String> tags;
  @JsonKey(name: FirestoreSchema.isAvailable, defaultValue: false)
  final bool isAvailable;
  @JsonKey(name: FirestoreSchema.description, defaultValue: "")
  final String description;
  @JsonKey(name: FirestoreSchema.itemSettings, defaultValue: [])
  final List<ItemSettingsTableModel> itemSettings;

  const ItemTableModel({
    required this.uuid,
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.category,
    required this.imageLink,
    required this.tags,
    required this.isAvailable,
    required this.itemSettings,
    required this.description,
  });

  factory ItemTableModel.fromJson(Map<String, dynamic> json) {
    ItemTableModel model = _$ItemTableModelFromJson(json);
    if (model.category == ProductCategory.disposablePod.name) {
      return DisposablePodTableModel.fromJson(json);
    } else if (model.category == ProductCategory.snus.name) {
      return SnusTableModel.fromJson(json);
    }
    throw Exception();
  }

  factory ItemTableModel.fromEntity(Item item) {
    if (item.category == ProductCategory.disposablePod.name) {
      return DisposablePodTableModel(
          uuid: item.uuid,
          id: item.id,
          name: item.name,
          price: item.price,
          oldPrice: item.oldPrice,
          category: item.category,
          imageLink: item.imageLink,
          tags: item.tags,
          isAvailable: item.isAvailable,
          description: item.description,
          itemSettings: item.itemSettings.map((e) => ItemSettingsTableModel.fromEntity(e)).toList(),
          puffsCount: (item as DisposablePodEntity).puffsCount);
    } else if (item.category == ProductCategory.snus.name) {
      return SnusTableModel(
          uuid: item.uuid,
          id: item.id,
          name: item.name,
          price: item.price,
          oldPrice: item.oldPrice,
          category: item.category,
          imageLink: item.imageLink,
          tags: item.tags,
          isAvailable: item.isAvailable,
          description: item.description,
          itemSettings: item.itemSettings.map((e) => ItemSettingsTableModel.fromEntity(e)).toList(),
          strength: (item as Snus).strength);
    }
    return ItemTableModel(
        uuid: item.uuid,
        id: item.id,
        name: item.name,
        price: item.price,
        oldPrice: item.oldPrice,
        category: item.category,
        imageLink: item.imageLink,
        tags: item.tags,
        isAvailable: item.isAvailable,
        description: item.description,
        itemSettings: item.itemSettings.map((e) => ItemSettingsTableModel.fromEntity(e)).toList());
  }

  Json toJson() {
    return _$ItemTableModelToJson(this);
  }
}
