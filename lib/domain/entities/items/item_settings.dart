import 'package:kurilki/data/models/items/abstract_item_settings_table_model.dart';
import 'package:kurilki/data/models/items/item_settings_table_model.dart';
import 'package:uuid/uuid.dart';

class AbstractItemSettings {
  final String name;
  final ItemSettingsType type;

  const AbstractItemSettings({
    required this.name,
    required this.type,
  });

  factory AbstractItemSettings.fromTableModel(AbstractItemsSettingsTableModel model) => AbstractItemSettings(
        name: model.name,
        type: model.type,
      );
}

class ItemSettings extends AbstractItemSettings {
  final String uuid;
  final String imageLink;
  final bool isAvailable;
  final int count;

  ItemSettings({
    String? uuid,
    required this.imageLink,
    required this.isAvailable,
    required this.count,
    required super.name,
    required super.type,
  }) : uuid = uuid ?? const Uuid().v4();

  ItemSettings copyWith({
    String? uuid,
    String? imageLink,
    bool? isAvailable,
    int? count,
    String? name,
    ItemSettingsType? type,
  }) {
    return ItemSettings(
        uuid: uuid ?? this.uuid,
        imageLink: imageLink ?? this.imageLink,
        isAvailable: isAvailable ?? this.isAvailable,
        count: count ?? this.count,
        name: name ?? this.name,
        type: type ?? this.type);
  }

  factory ItemSettings.fromTableModel(ItemSettingsTableModel model) => ItemSettings(
        uuid: model.uuid,
        name: model.name,
        imageLink: model.imageLink,
        isAvailable: model.isAvailable,
        count: model.count,
        type: model.type,
      );
}

class NoItemSettings extends AbstractItemSettings {
  NoItemSettings({required super.name, required super.type});
}

enum ItemSettingsType { filled, empty }
