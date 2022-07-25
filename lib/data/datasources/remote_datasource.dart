import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/models/disposable_pod_table_model.dart';
import 'package:kurilki/data/models/item_table_model.dart';
import 'package:kurilki/data/models/snus_table_model.dart';
import 'package:kurilki/domain/entities/item.dart';

@lazySingleton
class RemoteDataSource {
  final FirebaseFirestore _firestore;

  RemoteDataSource(this._firestore);

  Future<List<ItemTableModel>> loadAllItems() async {
    final userCollectionRef = _firestore.collection("products");
    QuerySnapshot ref = await userCollectionRef.get();

    List<ItemTableModel?> tempProductsList = ref.docs.map((e) {
      Json json = e.data() as Json;
      ItemTableModel abstractItem = ItemTableModel.fromJson(json);
      if (abstractItem.category == ProductCategory.disposablePod.name) {
        return DisposablePodTableModel.fromJson(json);
      } else if (abstractItem.category == ProductCategory.snus.name) {
        return SnusTableModel.fromJson(json);
      } else {
        return null;
      }
    }).toList();
    List<ItemTableModel> productsList =
        tempProductsList.where((element) => (element != null)).map((e) => e as ItemTableModel).toList();
    return productsList;
  }

  Future<void> createItem(ItemTableModel model) async {
    final userCollectionRef = _firestore.collection("products");
    await userCollectionRef.doc(model.uuid).set(model.toJson());
  }
}
