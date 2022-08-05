import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/data/models/admin/category_table_model.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/data/models/order/order_table_model.dart';
import 'package:kurilki/data/models/user/user_table_model.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/domain/entities/order/price_details.dart';
import 'package:kurilki/domain/entities/order/user_details.dart';
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
      return Item.fromTableModel(e);
    }).toList();
    List<Item> productsList = items.where((element) => element != null).map((e) => e as Item).toList();
    return productsList;
  }

  Future<List<Item>> loadItemsWithSameId(Item item) async {
    List<Item?> items = [];
    List<ItemTableModel> preItems = await _remoteDataSource.loadItemsWithSameId(item.category);

    items = preItems.map((e) {
      return Item.fromTableModel(e);
    }).toList();
    List<Item> productsList = items.where((element) => element != null).map((e) => e as Item).toList();
    return productsList;
  }

  Future<void> createOrder({
    required List<CartItem> items,
    required String name,
    required String address,
    required String phone,
    required DeliveryType deliveryType,
    required String payType,
  }) async {
    double price = 0;
    for (var item in items) {
      price += (item.count * item.item.price);
    }
    OrderEntity order = OrderEntity(
      items: items,
      user: UserDetails(
        name: name,
        number: phone,
        userId: (await _userId),
      ),
      number: (await _lastOrderNumber),
      deliveryDetails: DeliveryDetails(
        address: address,
        deliveryType: deliveryType,
        name: 'name',
        phone: phone,
      ),
      priceDetails: PriceDetails(
        totalPrice: price,
        itemsPrice: price,
        fullPrice: price,
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
      await _remoteDataSource.authWithGoogleAccount();
      logger.i("Successful authorization");
      return await getAccountEntity();
    } on Exception {
      rethrow;
    }
  }

  Future<UserEntity> getAccountEntity() async {
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
        return UserEntity.fromTableModel(model);
      } else {
        throw Exception("UserModel is empty");
      }
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> setAccountEntity(UserEntity entity) async {
    await _remoteDataSource.setAccountEntity(UserTableModel.fromEntity(entity));
  }

  Future<UserEntity> _createUser() async {
    try {
      final String authId = (await _remoteDataSource.userFromGoogleAuth).uid;
      final String name = (await _remoteDataSource.userFromGoogleAuth).displayName ?? 'error';
      final String imageLink = (await _remoteDataSource.userFromGoogleAuth).photoURL ?? 'error';
      UserEntity entity = UserEntity(
          authId: authId,
          name: name,
          imageLink: imageLink,
          deliveryDetails: const DeliveryDetails(
            address: "",
            deliveryType: DeliveryType.undefined,
            name: '',
            phone: '',
          ));
      await _remoteDataSource.createUser(UserTableModel.fromEntity(entity));
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
