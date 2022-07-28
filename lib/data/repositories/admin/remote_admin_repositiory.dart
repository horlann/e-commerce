import 'package:injectable/injectable.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/data/models/admin/category_table_model.dart';
import 'package:kurilki/data/models/items/disposable_pod_table_model.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/data/models/items/snus_table_model.dart';
import 'package:kurilki/data/models/order/cart_item_table_model.dart';
import 'package:kurilki/data/models/order/order_table_model.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/presentation/bloc/cart/cart_item.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class RemoteAdminRepository {
  final RemoteDataSource _remoteDataSource;

  const RemoteAdminRepository(this._remoteDataSource);

  Future<void> createItem() async {
    _remoteDataSource.createItem(ItemTableModel(
        uuid: const Uuid().v4(),
        id: '1',
        name: 'ElfBar Grape',
        price: 330,
        oldPrice: 0,
        category: 'disposablePod',
        imageLink: 'https://www.elfbar.com.ua/wp-content/uploads/2021/01/reverseside-2.jpg',
        tags: [],
        isAvailable: true));
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
            cartItems.add(CartItem(item: productsList[i], count: preItems[i].count));
          }

          return OrderEntity.fromTableModel(model, cartItems);
        }).toList());
  }
}
