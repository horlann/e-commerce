import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/common/exeptions/exeptions.dart';
import 'package:kurilki/common/failures/failures.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/data/models/admin/category_table_model.dart';
import 'package:kurilki/data/models/items/disposable_pod_table_model.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/data/models/items/snus_table_model.dart';
import 'package:kurilki/data/models/order/order_table_model.dart';
import 'package:kurilki/data/models/user/user_table_model.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/domain/entities/order/price_details.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
import 'package:kurilki/main.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class RemoteRepository {
  final RemoteDataSource _remoteDataSource;

  const RemoteRepository(this._remoteDataSource);

  Future<List<Item>> loadAllItems() async {
    List<Item?> items = [];
    List<ItemTableModel> preItems = await _remoteDataSource.loadAllItems();
    items = preItems.map((e) {
      if (e.category == ProductCategory.disposablePod.name) {
        return DisposablePodEntity.fromTableModel(e as DisposablePodTableModel);
      } else if (e.category == ProductCategory.snus.name) {
        return Snus.fromTableModel(e as SnusTableModel);
      } else {
        return null;
      }
    }).toList();
    List<Item> productsList = items.where((element) => element != null).map((e) => e as Item).toList();
    return productsList;
  }

  Future<List<Item>> loadItemsWithSameId(Item item) async {
    List<Item?> items = [];
    List<ItemTableModel> preItems = await _remoteDataSource.loadItemsWithSameId(item.category);

    items = preItems.map((e) {
      if (e.category == ProductCategory.disposablePod.name) {
        return DisposablePodEntity.fromTableModel(e as DisposablePodTableModel);
      } else if (e.category == ProductCategory.snus.name) {
        return Snus.fromTableModel(e as SnusTableModel);
      } else {
        return null;
      }
    }).toList();
    List<Item> productsList = items.where((element) => element != null).map((e) => e as Item).toList();
    return productsList;
  }

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

  Future<void> createOrder({
    required String name,
    required List<String> items,
    required String address,
    required DeliveryType deliveryType,
    required PayType payType,
  }) async {
    OrderEntity order = OrderEntity(
      name: name,
      number: (await _lastOrderNumber),
      userId: (await _userId),
      deliveryDetails: DeliveryDetails(
        address: address,
        deliveryType: deliveryType,
      ),
      itemsUuid: items,
      priceDetails: PriceDetails(
        totalPrice: 10,
        itemsPrice: 100,
        fullPrice: 120,
        deliveryPrice: 20,
        type: payType,
      ),
    );
    await _remoteDataSource.createOrder(OrderTableModel.fromEntity(order));
  }

  Future<int> get _lastOrderNumber async {
    int number = 1;

    try {
      OrderTableModel order = await _remoteDataSource.lastOrder;
      number = order.number;
      return ++number;
    } catch (e) {
      return 1;
    }
  }

  Future<String> get _userId async {
    try {
      User user = await _remoteDataSource.userFromGoogleAuth;
      return user.uid;
    } on Exception catch (e) {
      if (e == Exception("User is not authorized")) {
        return "User is not authorized";
      }
    }
    return "";
  }

  Future<void> createCategory(String name, String imageLink) async {
    await _remoteDataSource.createCategory(CategoryTableModel(
      id: 1,
      name: name,
      imageLink: imageLink,
      uuid: const Uuid().v4(),
    ));
  }

  Future<UserEntity> authWithGoogleAccount() async {
    try {
      final result = await _remoteDataSource.authWithGoogleAccount();
      logger.i("Successful authorization");
      return await getAccountEntity();
    } on Exception {
      rethrow;
    }
  }

  Future<UserEntity> getAccountEntity() async {
    UserEntity? entity;
    try {
      UserTableModel? model;
      try {
        model = (await _remoteDataSource.getAccountModel());
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          return await _createUser();
        }
      }
      if (model != null) {
        return entity = UserEntity.fromTableModel(model);
      } else {
        throw Exception("UserModel is empty");
      }
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<UserEntity> _createUser() async {
    try {
      final String authId = (await _remoteDataSource.userFromGoogleAuth).uid;
      final String name = (await _remoteDataSource.userFromGoogleAuth).displayName ?? 'error';
      final String imageLink = (await _remoteDataSource.userFromGoogleAuth).photoURL ?? 'error';
      UserEntity entity = UserEntity(authId: authId, name: name, imageLink: imageLink);
      final result = await _remoteDataSource.createUser(UserTableModel.fromEntity(entity));
      return entity;
    } on Exception {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
      return;
    } on Exception {
      rethrow;
    }
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
