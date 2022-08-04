import 'package:kurilki/data/models/items/disposable_pod_table_model.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';

import 'item.dart';

class DisposablePodEntity extends Item {
  DisposablePodEntity({
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
    required this.puffsCount,
    required super.isPopular,
    required super.description,
  });

  final int puffsCount;
  factory DisposablePodEntity.fromTableModel(DisposablePodTableModel model) => DisposablePodEntity(
      uuid: model.uuid,
      id: model.id,
      name: model.name,
      price: model.price,
      oldPrice: model.oldPrice,
      category: model.category,
      imageLink: model.imageLink,
      isAvailable: model.isAvailable,
      tags: model.tags,
      puffsCount: model.puffsCount,
      description: model.description,
      isPopular: model.isPopular,
      itemSettings: model.itemSettings.map((e) => ItemSettings.fromTableModel(e)).toList());

  DisposablePodEntity copyWith({
    int? puffsCount,
    List<ItemSettings>? itemSettings,
    String? name,
    String? category,
    String? id,
    String? imageLink,
    bool? isAvailable,
    double? oldPrice,
    double? price,
    List<String>? tags,
    String? uuid,
    String? description,
    bool? isPopular,
  }) {
    return DisposablePodEntity(
      category: category ?? this.category,
      id: id ?? this.id,
      imageLink: imageLink ?? this.imageLink,
      isAvailable: isAvailable ?? this.isAvailable,
      name: name ?? this.name,
      oldPrice: oldPrice ?? this.oldPrice,
      price: price ?? this.price,
      puffsCount: puffsCount ?? this.puffsCount,
      itemSettings: itemSettings ?? this.itemSettings,
      tags: tags ?? this.tags,
      uuid: uuid ?? this.uuid,
      isPopular: isPopular ?? this.isPopular,
      description: description ?? this.description,
    );
  }
}
