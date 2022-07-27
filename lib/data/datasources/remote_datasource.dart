import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/common/failures/failures.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/account_firestore_schema.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
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

  Future<Either<Failure, UserTableModel>> authWithGoogleAccount() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return const Left(FirebaseAuthFailure());

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        await _auth.signInWithCredential(credential);
        logger.i("Successful authorization");
        final response = await getAccountEntity();
        return response.fold(
          (l) => Left(l),
          (r) => Right(r),
        );
      } on PlatformException catch (e) {
        rethrow;
      }
    } on PlatformException catch (e) {
      //TODO: not implemented yet
      switch (e.code) {
        case "account-exists-with-different-credential":
          break;
        case "invalid-credential":
          break;
        case "operation-not-allowed":
          break;
        case "user-disabled":
          break;
      }
      logger.e(e.code);
      return const Left(FirebaseAuthFailure());
    }
  }

  Future<Either<Failure, UserTableModel>> getAccountEntity() async {
    UserTableModel userTableModel;
    try {
      if (_auth.currentUser != null) {
        final userCollectionRef = _firestore.collection("accounts");
        final uuid = _auth.currentUser!.uid;

        final document = await userCollectionRef.doc(uuid).get();
        if (document.data() == null) {
          await userCollectionRef.doc(uuid).set({
            AccountFirestoreSchema.uuid: uuid,
            AccountFirestoreSchema.name: _auth.currentUser!.displayName,
            AccountFirestoreSchema.imageLink: _auth.currentUser!.photoURL,
          });
        }
        DocumentSnapshot snapshot = await userCollectionRef.doc(uuid).get();
        userTableModel = UserTableModel.fromJson(snapshot.data() as Json);
        print(userTableModel.toJson());
        return Right(userTableModel);
      } else {
        return const Left(FirebaseForbiddenAccessFailure());
      }
    } on Exception catch (e) {
      logger.e(e);
      return const Left(FirebaseUnknownFailure());
    }
  }

  Future<Either<Failure, bool>> logout() async {
    try {
      await _googleSignIn.disconnect();
      await _auth.signOut();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      return const Left(FirebaseAuthFailure());
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
    QuerySnapshot ref = await userCollectionRef
        .orderBy('orderNumber', descending: true)
        .where(FirestoreSchema.categoryName, isEqualTo: id)
        .get();
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
