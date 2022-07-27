import 'package:kurilki/data/models/items/snus_table_model.dart';

import 'item.dart';

class Snus extends Item {
  Snus(
      {required super.uuid,
      required super.id,
      required super.name,
      required super.price,
      required super.oldPrice,
      required super.category,
      required super.imageLink,
      required super.isAvailable,
      required super.tags,
      required this.strength});

  final int strength;
  factory Snus.fromTableModel(SnusTableModel model) => Snus(
      uuid: model.uuid,
      id: model.id,
      name: model.name,
      price: model.price,
      oldPrice: model.oldPrice,
      category: ProductCategory.values.firstWhere((e) => e.toString() == model.category),
      imageLink: model.imageLink,
      isAvailable: model.isAvailable,
      tags: model.tags,
      strength: model.strength);
}
