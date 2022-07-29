import 'package:kurilki/data/models/items/disposable_pod_table_model.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';

import 'item.dart';

class DisposablePodEntity extends Item {
  DisposablePodEntity(
      {required super.uuid,
      required super.id,
      required super.name,
      required super.price,
      required super.oldPrice,
      required super.category,
      required super.imageLink,
      required super.isAvailable,
      required super.tags,
      required this.puffsCount,
      required this.itemSettings});

  final int puffsCount;
  final List<ItemSettings> itemSettings;
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
      itemSettings: model.itemSettings.map((e) => ItemSettings.fromTableModel(e)).toList());
}
