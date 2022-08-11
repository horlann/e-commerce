import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/key_value_api/shards.dart';
import 'package:kurilki/data/models/order/cart_item_table_model.dart';

abstract class IKeyValueDataSource {
  Future<void> cacheCart(List<CartItemTableModel> items);

  Future<List<CartItemTableModel>> loadCachedCart();
}

@Singleton(as: IKeyValueDataSource)
class ShardsDataSource extends SharedPreferencesDao implements IKeyValueDataSource {
  ShardsDataSource(super.sharedPreferences);

  @override
  Future<void> cacheCart(List<CartItemTableModel> items) async {
    List<Json> json = items.map((e) => e.toJson()).toList();
    await setString('cartCache', jsonEncode(json));
  }

  @override
  Future<List<CartItemTableModel>> loadCachedCart() async {
    final String jsonString = getString('cartCache') ?? '';
    //print(jsonString);

    return [];
  }
}
