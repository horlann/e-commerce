import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/common/failures/failures.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/data/models/category_table_model.dart';
import 'package:kurilki/data/models/disposable_pod_table_model.dart';
import 'package:kurilki/data/models/item_table_model.dart';
import 'package:kurilki/data/models/snus_table_model.dart';
import 'package:kurilki/domain/entities/category_entity.dart';
import 'package:kurilki/domain/entities/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/item.dart';
import 'package:kurilki/domain/entities/snus.dart';
import 'package:kurilki/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

@singleton
class RemoteRepository {
  final RemoteDataSource _remoteDataSource;

  RemoteRepository(this._remoteDataSource);

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

  Future<Either<Failure, AccountEntity>> authWithGoogleAccount() async {
    return await _remoteDataSource.authWithGoogleAccount();
  }

  Future<Either<Failure, AccountEntity>> getAccountEntity() async {
    return await _remoteDataSource.getAccountEntity();
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

  Future<void> addNewCategory(String name, String imageLink) async {
    await _remoteDataSource.addNewCategory(CategoryTableModel(
      id: 1,
      name: name,
      imageLink: imageLink,
      uuid: const Uuid().v4(),
    ));
  }
}
