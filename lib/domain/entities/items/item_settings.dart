import 'package:uuid/uuid.dart';

import 'package:kurilki/common/const/const.dart';
import 'package:kurilki/data/models/items/item_settings_table_model.dart';

class ItemSettings {
  final String name;
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
    required this.name,
  }) : uuid = uuid ?? const Uuid().v4();

  ItemSettings.empty({
    required this.uuid,
    required this.imageLink,
    required this.isAvailable,
    required this.count,
    this.isPopular = false,
  }) : name = Const.empty;

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
        other.name == name &&
        other.uuid == uuid &&
        other.imageLink == imageLink &&
        other.isAvailable == isAvailable &&
        other.count == count &&
        other.isPopular == isPopular;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uuid.hashCode ^
        imageLink.hashCode ^
        isAvailable.hashCode ^
        count.hashCode ^
        isPopular.hashCode;
  }

  @override
  String toString() {
    return 'ItemSettings(name: $name, uuid: $uuid, imageLink: $imageLink, isAvailable: $isAvailable, count: $count, isPopular: $isPopular)';
  }
}
