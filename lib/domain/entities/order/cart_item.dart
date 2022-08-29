import 'package:kurilki/data/models/order/cart_item_table_model.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';

class CartItem {
  final Item item;
  final ItemSettings itemSettings;
  final int count;

  const CartItem({
    required this.item,
    required this.itemSettings,
    required this.count,
  });

  CartItem copyWith({
    Item? item,
    ItemSettings? itemSettings,
    int? count,
  }) {
    return CartItem(
      item: item ?? this.item,
      itemSettings: itemSettings ?? this.itemSettings,
      count: count ?? this.count,
    );
  }

  factory CartItem.fromTableModel(CartItemTableModel model) => CartItem(
        count: model.count,
        item: Item.fromTableModel(model.item),
        itemSettings: ItemSettings.fromTableModel(model.itemSettings),
      );

  @override
  String toString() => 'CartItem(item: $item, itemSettings: $itemSettings, count: $count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem && other.item == item && other.itemSettings == itemSettings && other.count == count;
  }

  @override
  int get hashCode => item.hashCode ^ itemSettings.hashCode ^ count.hashCode;
}
