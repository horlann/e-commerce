import 'package:kurilki/data/models/items/abstract_item_settings_table_model.dart';
import 'package:kurilki/data/models/items/item_settings_table_model.dart';
import 'package:uuid/uuid.dart';

class AbstractItemSettings {
  final String name;

  const AbstractItemSettings({
    required this.name,
  });

  factory AbstractItemSettings.fromTableModel(AbstractItemsSettingsTableModel model) {
    if (model is ItemSettingsTableModel) {
      return ItemSettings.fromTableModel(model);
    } else {
      return NoItemSettings(
        name: model.name,
      );
    }
  }
}

class ItemSettings extends AbstractItemSettings {
  final String uuid;
  final String imageLink;
  final bool isAvailable;
  final int count;
  final bool isPopular;

  ItemSettings({
    String? uuid,
    required this.imageLink,
    required this.isAvailable,
    required this.count,
    required this.isPopular,
    required super.name,
  }) : uuid = uuid ?? const Uuid().v4();

  ItemSettings copyWith({
    String? uuid,
    String? imageLink,
    bool? isAvailable,
    int? count,
    String? name,
    bool? isPopular,
  }) {
    return ItemSettings(
        uuid: uuid ?? this.uuid,
        imageLink: imageLink ?? this.imageLink,
        isAvailable: isAvailable ?? this.isAvailable,
        count: count ?? this.count,
        isPopular: isPopular ?? this.isPopular,
        name: name ?? this.name);
  }

  factory ItemSettings.fromTableModel(ItemSettingsTableModel model) => ItemSettings(
        uuid: model.uuid,
        name: model.name,
        imageLink: model.imageLink,
        isAvailable: model.isAvailable,
        count: model.count,
        isPopular: model.isPopular,
      );
}

class NoItemSettings extends AbstractItemSettings {
  NoItemSettings({required super.name});
}
