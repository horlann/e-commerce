import 'package:kurilki/data/models/items/snus_table_model.dart';

import 'item.dart';
import 'item_settings.dart';

class Snus extends Item {
  Snus({
    required super.uuid,
    required super.id,
    required super.name,
    required super.price,
    required super.oldPrice,
    required super.category,
    required super.imageLink,
    required super.isAvailable,
    required super.tags,
    required super.itemSettings,
    required this.strength,
    required super.isPopular,
    required super.description,
  });

  final int strength;
  factory Snus.fromTableModel(SnusTableModel model) => Snus(
      uuid: model.uuid,
      id: model.id,
      name: model.name,
      price: model.price,
      oldPrice: model.oldPrice,
      category: model.category,
      imageLink: model.imageLink,
      isAvailable: model.isAvailable,
      tags: model.tags,
      strength: model.strength,
      description: model.description,
      isPopular: model.isPopular,
      itemSettings: model.itemSettings.map((e) => ItemSettings.fromTableModel(e)).toList());

  Snus copyWith({
    int? strength,
    String? name,
    String? category,
    String? id,
    String? imageLink,
    bool? isAvailable,
    double? oldPrice,
    double? price,
    List<String>? tags,
    String? uuid,
    List<ItemSettings>? itemSettings,
    String? description,
    bool? isPopular,
  }) {
    return Snus(
      strength: strength ?? this.strength,
      category: category ?? this.category,
      id: id ?? this.id,
      imageLink: imageLink ?? this.imageLink,
      isAvailable: isAvailable ?? this.isAvailable,
      name: name ?? this.name,
      oldPrice: oldPrice ?? this.oldPrice,
      price: price ?? this.price,
      tags: tags ?? this.tags,
      uuid: uuid ?? this.uuid,
      itemSettings: itemSettings ?? this.itemSettings,
      isPopular: isPopular ?? this.isPopular,
      description: description ?? this.description,
    );
  }
}
