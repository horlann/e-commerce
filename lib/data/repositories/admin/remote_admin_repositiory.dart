import 'package:injectable/injectable.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/data/models/admin/category_table_model.dart';
import 'package:kurilki/data/models/items/disposable_pod_table_model.dart';
import 'package:kurilki/data/models/items/item_settings_table_model.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/data/models/items/snus_table_model.dart';
import 'package:kurilki/data/models/order/cart_item_table_model.dart';
import 'package:kurilki/data/models/order/order_table_model.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class RemoteAdminRepository {
  final RemoteDataSource _remoteDataSource;

  const RemoteAdminRepository(this._remoteDataSource);

  Future<void> updateItem(Item updatedItem) async {
    if (updatedItem is Snus) {
      _remoteDataSource.updateItem(
        SnusTableModel(
          uuid: updatedItem.uuid,
          id: updatedItem.id,
          name: updatedItem.name,
          price: updatedItem.price,
          oldPrice: updatedItem.oldPrice,
          category: updatedItem.category,
          imageLink: updatedItem.imageLink,
          tags: updatedItem.tags,
          isAvailable: updatedItem.isAvailable,
          strength: updatedItem.strength,
          itemSettings: [],
        ),
      );
    } else if (updatedItem is DisposablePodEntity) {
      final List<ItemSettingsTableModel> itemSettings = [];
      for (var settings in updatedItem.itemSettings) {
        itemSettings.add(ItemSettingsTableModel.fromEntity(settings));
      }
      _remoteDataSource.updateItem(
        DisposablePodTableModel(
          uuid: updatedItem.uuid,
          id: updatedItem.id,
          name: updatedItem.name,
          price: updatedItem.price,
          oldPrice: updatedItem.oldPrice,
          category: updatedItem.category,
          imageLink: updatedItem.imageLink,
          tags: updatedItem.tags,
          isAvailable: updatedItem.isAvailable,
          itemSettings: itemSettings,
          puffsCount: updatedItem.puffsCount,
        ),
      );
    }
  }

  Future<void> createItem(Item item) async {
    _remoteDataSource.createItem(ItemTableModel.fromEntity(item));
  }

  Future<void> createCategory(String name, String imageLink) async {
    await _remoteDataSource.createCategory(CategoryTableModel(
      id: 1,
      name: name,
      imageLink: imageLink,
      uuid: const Uuid().v4(),
    ));
  }

  Stream<List<OrderEntity>> ordersStream() {
    Stream<List<OrderTableModel>> stream = _remoteDataSource.ordersStream();
    return stream.map((event) => event.map((e) {
          OrderTableModel model = e;
          List<CartItemTableModel> preItems = e.items;

          List<Item?> items = preItems.map((e) {
            if (e.item.category == ProductCategory.disposablePod.name) {
              return DisposablePodEntity.fromTableModel(e.item as DisposablePodTableModel);
            } else if (e.item.category == ProductCategory.snus.name) {
              return Snus.fromTableModel(e.item as SnusTableModel);
            } else {
              return null;
            }
          }).toList();
          List<Item> productsList = items.where((element) => element != null).map((e) => e as Item).toList();
          List<CartItem> cartItems = [];
          for (int i = 0; i < productsList.length; i++) {
            cartItems.add(CartItem(
                item: productsList[i],
                count: preItems[i].count,
                itemSettings: NoItemSettings(type: ItemSettingsType.empty, name: 'empty')));
          }

          return OrderEntity.fromTableModel(model, cartItems);
        }).toList());
  }
}
