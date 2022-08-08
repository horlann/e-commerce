import 'package:injectable/injectable.dart';
import 'package:kurilki/data/datasources/shards_datasource.dart';
import 'package:kurilki/data/models/order/cart_item_table_model.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';

@singleton
class LocalRepository {
  final IKeyValueDataSource shardsDao;

  LocalRepository(this.shardsDao);

  Future<void> cacheCart(List<CartItem> items) async {
    List<CartItemTableModel> cartItems = items.map((e) => CartItemTableModel.fromEntity(e)).toList();
    await shardsDao.cacheCart(cartItems);
  }

  Future<List<CartItem>> getCartCache() async {
    List<CartItemTableModel> cartItems = await shardsDao.loadCachedCart();
    List<CartItem> items = cartItems.map((e) => CartItem.fromTableModel(e)).toList();
    return items;
  }
}
