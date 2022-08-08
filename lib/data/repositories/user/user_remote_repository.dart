import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/data/models/user/user_table_model.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
import 'package:kurilki/main.dart';

@lazySingleton
class UserRemoteRepository {
  final RemoteDataSource _remoteDataSource;

  const UserRemoteRepository(this._remoteDataSource);

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
}
