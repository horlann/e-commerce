import 'package:kurilki/data/models/items/item_settings_table_model.dart';

class ItemSettings {
  final String name;
  final String imageLink;
  final bool isAvailable;
  final int count;

  const ItemSettings({
    required this.name,
    required this.imageLink,
    required this.isAvailable,
    required this.count,
  });

  ItemSettings copyWith({
    String? name,
    String? imageLink,
    bool? isAvailable,
    int? count,
  }) {
    return ItemSettings(
      name: name ?? this.name,
      imageLink: imageLink ?? this.imageLink,
      isAvailable: isAvailable ?? this.isAvailable,
      count: count ?? this.count,
    );
  }

  factory ItemSettings.fromTableModel(ItemSettingsTableModel model) => ItemSettings(
        name: model.name,
        imageLink: model.imageLink,
        isAvailable: model.isAvailable,
        count: model.count,
      );
}
