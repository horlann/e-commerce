import 'package:kurilki/data/models/items/item_settings_table_model.dart';
import 'package:uuid/uuid.dart';

class ItemSettings {
  final String uuid;
  final String name;
  final String imageLink;
  final bool isAvailable;
  final int count;

  ItemSettings({
    String? uuid,
    required this.name,
    required this.imageLink,
    required this.isAvailable,
    required this.count,
  }) : uuid = uuid ?? const Uuid().v4();

  ItemSettings copyWith({
    String? uuid,
    String? name,
    String? imageLink,
    bool? isAvailable,
    int? count,
  }) {
    return ItemSettings(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      imageLink: imageLink ?? this.imageLink,
      isAvailable: isAvailable ?? this.isAvailable,
      count: count ?? this.count,
    );
  }

  factory ItemSettings.fromTableModel(ItemSettingsTableModel model) => ItemSettings(
      uuid: model.uuid,
      name: model.name,
      imageLink: model.imageLink,
      isAvailable: model.isAvailable,
      count: model.count);
}
