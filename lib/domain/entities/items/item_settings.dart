import 'package:uuid/uuid.dart';

import 'package:kurilki/data/models/items/abstract_item_settings_table_model.dart';
import 'package:kurilki/data/models/items/item_settings_table_model.dart';

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AbstractItemSettings && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class ItemSettings extends AbstractItemSettings {
  final String uuid;
  final String imageLink;
  final bool isAvailable;
  final int count;
  final bool isPopular;

  ItemSettings({
    String? uuid,
    this.imageLink = "https://i.ibb.co/2qQqzdR/e.png",
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemSettings &&
        other.uuid == uuid &&
        other.imageLink == imageLink &&
        other.isAvailable == isAvailable &&
        other.count == count &&
        other.isPopular == isPopular;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^ imageLink.hashCode ^ isAvailable.hashCode ^ count.hashCode ^ isPopular.hashCode;
  }
}

class NoItemSettings extends AbstractItemSettings {
  NoItemSettings({required super.name});
}
