import 'package:injectable/injectable.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/data/models/admin/category_table_model.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class RemoteRepository {
  final RemoteDataSource _remoteDataSource;

  const RemoteRepository(this._remoteDataSource);

  Future<List<Item>> loadAllItems() async {
    List<Item?> items = [];
    List<ItemTableModel> preItems = await _remoteDataSource.loadAllItems();
    items = preItems.map((e) {
      return Item.fromTableModel(e);
    }).toList();
    List<Item> productsList = items.where((element) => element != null).map((e) => e as Item).toList();
    return productsList;
  }

  Future<void> createCategory(
    String name,
  ) async {
    await _remoteDataSource.createCategory(CategoryTableModel(
      name: name,
      uuid: const Uuid().v4(),
    ));
  }

  Future<List<CategoryEntity>> getCategoriesList() async {
    List<CategoryEntity> entities = [];
    try {
      final result = await _remoteDataSource.getCategoriesList();
      List<CategoryTableModel> models = result;
      for (var model in models) {
        entities.add(CategoryEntity.fromTableModel(model));
      }
      return entities;
    } on Exception {
      rethrow;
    }
  }
}
