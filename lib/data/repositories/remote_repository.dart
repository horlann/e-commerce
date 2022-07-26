import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/common/failures/failures.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/data/models/items/disposable_pod_table_model.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/data/models/items/snus_table_model.dart';
import 'package:kurilki/data/models/order/order_table_model.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/domain/entities/order/price_details.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
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

  Future<Either<Failure, AccountEntity>> authWithGoogleAccount() async {
    return await _remoteDataSource.authWithGoogleAccount();
  }

  Future<Either<Failure, AccountEntity>> getAccountEntity() async {
    return await _remoteDataSource.getAccountEntity();
  }

  Future<Either<Failure, bool>> logout() async {
    return await _remoteDataSource.logout();
  }
}
