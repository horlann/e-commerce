import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';

class PopularItem {
  final Item item;
  final ItemSettings itemSettings;

  PopularItem({
    required this.item,
    required this.itemSettings,
  });
}
