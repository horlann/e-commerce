import 'package:kurilki/domain/entities/items/item.dart';

class CartItem {
  final Item item;
  final int count;

  const CartItem({
    required this.item,
    required this.count,
  });

  @override
  String toString() {
    return 'CartItem{item: $item, count: $count}';
  }

  CartItem copyWith({
    Item? item,
    int? count,
  }) {
    return CartItem(
      item: item ?? this.item,
      count: count ?? this.count,
    );
  }
}
