import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/domain/entities/items/item.dart';

part 'item_table_model.g.dart';

@JsonSerializable()
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
  });

  factory ItemTableModel.fromJson(Map<String, dynamic> json) => _$ItemTableModelFromJson(json);

  factory ItemTableModel.fromEntity(Item item) => ItemTableModel(
      uuid: item.uuid,
      id: item.id,
      name: item.name,
      price: item.price,
      oldPrice: item.oldPrice,
      category: item.category,
      imageLink: item.imageLink,
      tags: item.tags,
      isAvailable: item.isAvailable);

  Json toJson() => _$ItemTableModelToJson(this);
}
