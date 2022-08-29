import 'package:kurilki/data/models/user/history_item_table_model.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/order/order.dart';

class HistoryItem {
  final Item item;
  final ItemSettings itemSettings;
  final DateTime? completedAt;
  final DateTime createdAt;
  final OrderStatus orderStatus;

  HistoryItem({
    required this.item,
    required this.itemSettings,
    required this.createdAt,
    required this.orderStatus,
    this.completedAt,
  });

  factory HistoryItem.fromTableModel(HistoryItemTableModel model) => HistoryItem(
        item: Item.fromTableModel(model.item),
        itemSettings: ItemSettings.fromTableModel(model.itemSettings),
        createdAt: model.createdAt,
        orderStatus: model.orderStatus,
        completedAt: model.completedAt,
      );
}
