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
      category: model.category,
      imageLink: model.imageLink,
      isAvailable: model.isAvailable,
      tags: model.tags,
      strength: model.strength);

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
    );
  }
}
