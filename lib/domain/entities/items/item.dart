import 'package:kurilki/data/models/items/disposable_pod_table_model.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/data/models/items/snus_table_model.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:uuid/uuid.dart';

import 'item_settings.dart';

abstract class Item {
  final String uuid;

  final String id;

  final String name;

  final double price;

  final double oldPrice;

  final String category;

  final String imageLink;

  final List<String> tags;

  final bool isAvailable;

  final List<ItemSettings> itemSettings;

  final String description;

  Item({
    String? uuid,
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

  }) : uuid = uuid ?? const Uuid().v4();

  factory Item.fromTableModel(ItemTableModel item) {
    if (item.category == ProductCategory.disposablePod.name) {
      return DisposablePodEntity(
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
          itemSettings: item.itemSettings.map((e) => ItemSettings.fromTableModel(e)).toList(),
          puffsCount: (item as DisposablePodTableModel).puffsCount);
    } else if (item.category == ProductCategory.snus.name) {
      return Snus(
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
          itemSettings: item.itemSettings.map((e) => ItemSettings.fromTableModel(e)).toList(),
          strength: (item as SnusTableModel).strength);
    }
    throw Exception();
  }
}

enum ProductCategory { disposablePod, snus, unidentified }
