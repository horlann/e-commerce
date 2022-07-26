import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kurilki/data/api/rest_api/schemas/account_firestore_schema.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';

class UserTableModel extends AccountEntity {
  UserTableModel({
    final String uuid = "",
    final String name = "",
    final String imageLink = "",
  }) : super(
          uuid: uuid,
          name: name,
          imageLink: imageLink,
        );

  factory UserTableModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserTableModel(
      uuid: documentSnapshot.get(AccountFirestoreSchema.uuid),
      name: documentSnapshot.get(AccountFirestoreSchema.name),
      imageLink: documentSnapshot.get(AccountFirestoreSchema.imageLink),
    );
  }
}
