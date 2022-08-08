import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/data/models/order/cart_item_table_model.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';

class CartItem {
  final Item item;
  final AbstractItemSettings itemSettings;
  final int count;

  const CartItem({
    required this.item,
    required this.itemSettings,
    required this.count,
  });

  @override
  String toString() {
    return 'CartItem{item: $item,itemSettings:$itemSettings, count: $count}';
  }

  CartItem copyWith({
    Item? item,
    AbstractItemSettings? itemSettings,
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
        itemSettings: AbstractItemSettings.fromTableModel(model.itemSettings),
      );
}
