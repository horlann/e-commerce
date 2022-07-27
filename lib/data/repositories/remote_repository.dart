import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
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

  Future<void> createOrder({required List<String> items}) async {
    OrderEntity order = OrderEntity(
        number: (await _lastOrderNumber),
        userId: 'id',
        deliveryDetails: const DeliveryDetails(address: 'adress', deliveryType: DeliveryType.delivery),
        itemsUuid: items,
        priceDetails: PriceDetails(totalPrice: 10, itemsPrice: 100, fullPrice: 120, deliveryPrice: 20));
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

  Future<void> createCategory(String name, String imageLink) async {
    await _remoteDataSource.createCategory(CategoryTableModel(
      id: 1,
      name: name,
      imageLink: imageLink,
      uuid: const Uuid().v4(),
    ));
  }

  Future<Either<Failure, UserEntity>> authWithGoogleAccount() async {
    UserEntity? entity;
    final result = (await _remoteDataSource.authWithGoogleAccount());
    await result.fold(
      (l) {
        return const Left(FirebaseUnknownFailure());
      },
      (r) async {
        if (r) {
          final response = await getAccountEntity();
          await response.fold(
            (l) {
              return Left(l);
            },
            (r) {
              logger.i("Successful authorization");
              entity = r;
              print(r.toString());

              return Right(r);
            },
          );
        } else {}

        return Right(entity);
      },
    );
    print(entity.toString());

    if (entity != null) {
      return Right(entity!);
    }
    print('sho');

    return const Left(FirebaseUnknownFailure());
  }

  Future<Either<Failure, UserEntity>> getAccountEntity() async {
    UserEntity? entity;
    final result = (await _remoteDataSource.getAccountEntity());
    result.fold(
      (l) async {
        print('create1');

        return await _createUser();
      },
      (r) {
        print('create2');

        UserTableModel userTableModel = r;
        entity = UserEntity.fromTableModel(userTableModel);
        return Right(entity);
      },
    );
    if (entity != null) {
      return Right(entity!);
    }

    return const Left(FirebaseUnknownFailure());
  }

  Future<Either<Failure, UserEntity>> _createUser() async {
    final String authId = (await _remoteDataSource.userFromGoogleAuth).uid;
    final String name = (await _remoteDataSource.userFromGoogleAuth).displayName ?? 'error';
    final String imageLink = (await _remoteDataSource.userFromGoogleAuth).photoURL ?? 'error';
    UserEntity entity = UserEntity(authId: authId, name: name, imageLink: imageLink);
    final result = await _remoteDataSource.createUser(UserTableModel.fromEntity(entity));

    result.fold(
      (l) => const Left(FirebaseUnknownFailure()),
      (r) {
        return Right(r);
      },
    );

    return const Left(FirebaseUnknownFailure());
  }

  Future<Either<Failure, bool>> logout() async {
    return await _remoteDataSource.logout();
  }

  Future<Either<Failure, List<CategoryEntity>>> getCategoriesList() async {
    List<CategoryEntity> entity = [];
    final result = await _remoteDataSource.getCategoriesList();
    result.fold(
      (l) => const Left(FirebaseUnknownFailure()),
      (r) {
        List<CategoryTableModel> models = r;
        for (var model in models) {
          entity.add(CategoryEntity.fromTableModel(model));
        }
        return Right(entity);
      },
    );
    return Right(entity);
  }
}
