import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/data/models/admin/category_table_model.dart';
import 'package:kurilki/data/models/items/disposable_pod_table_model.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/data/models/items/snus_table_model.dart';
import 'package:kurilki/data/models/order/order_table_model.dart';
import 'package:kurilki/data/models/user/user_table_model.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/main.dart';

@lazySingleton
class RemoteDataSource {
  final _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  RemoteDataSource(this._firestore, this._auth);

  Future<void> authWithGoogleAccount() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception("Account selection error");

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        await _auth.signInWithCredential(credential);
        return;
      } catch (e) {
        _auth.signOut();
        rethrow;
      }
    } on Exception catch (e) {
      logger.e(e);
      _googleSignIn.disconnect();
      _auth.signOut();
      rethrow;
    }
  }

  Future<UserTableModel> getAccountModel() async {
    try {
      if (_auth.currentUser != null) {
        final userCollectionRef = _firestore.collection("accounts");
        final authId = _auth.currentUser!.uid;

        final QuerySnapshot document =
            await userCollectionRef.where(FirestoreSchema.authId, isEqualTo: authId).limit(1).get();
        if (document.docs.isEmpty) {
          throw FirebaseAuthException(code: "user-not-found");
        }
        UserTableModel userTableModel = UserTableModel.fromJson(document.docs.first.data() as Json);
        return userTableModel;
      } else {
        throw Exception("User is not authorized");
      }
    } on Exception {
      rethrow;
    }
  }

  Future<UserTableModel> createUser(UserTableModel tableModel) async {
    try {
      final userCollectionRef = _firestore.collection("accounts");
      await userCollectionRef.doc(tableModel.uuid).set(tableModel.toJson());
      return tableModel;
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<User> get userFromGoogleAuth async {
    try {
      if (_auth.currentUser != null) {
        return _auth.currentUser!;
      } else {
        throw Exception("User is not authorized");
      }
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<List<CategoryTableModel>> getCategoriesList() async {
    try {
      final userCollectionRef = _firestore.collection("admin");
      QuerySnapshot ref = await userCollectionRef.get();

      List<CategoryTableModel> models = ref.docs.map((e) {
        Json json = e.data() as Json;
        return CategoryTableModel.fromJson(json);
      }).toList();

      return models;
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.disconnect();
      await _auth.signOut();
      return;
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

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

  Future<List<ItemTableModel>> loadItemsWithSameId(String id) async {
    final userCollectionRef = _firestore.collection("products");
    QuerySnapshot ref = await userCollectionRef.where(FirestoreSchema.categoryName, isEqualTo: id).get();
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

  Future<void> createCategory(CategoryTableModel model) async {
    final userCollectionRef = _firestore.collection("admin");
    await userCollectionRef.doc(model.uuid).set(model.toJson());
  }

  Future<void> createOrder(OrderTableModel orderTableModel) async {
    final userCollectionRef = _firestore.collection("orders");
    await userCollectionRef.doc(orderTableModel.uuid).set(orderTableModel.toJson());
  }

  Future<OrderTableModel> get lastOrder async {
    final ordersCollection = _firestore.collection("orders");

    QuerySnapshot snap = await ordersCollection.orderBy(FirestoreSchema.number, descending: true).limit(1).get();

    List<QueryDocumentSnapshot> docs = snap.docs;
    OrderTableModel orderTableModel = OrderTableModel.fromJson(docs.first.data() as Map<String, dynamic>);
    if (docs.isNotEmpty) {
      return orderTableModel;
    } else {
      throw Exception('Orders empty');
    }
  }
}
