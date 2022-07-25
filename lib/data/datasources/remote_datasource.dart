import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kurilki/common/failures/failures.dart';
import 'package:kurilki/data/api/rest_api/schemas/account_firestore_schema.dart';
import 'package:kurilki/data/models/user_table_model.dart';
import 'package:kurilki/domain/entities/remote/firebase/user_entity.dart';
import 'package:kurilki/main.dart';

class RemoteDataSource {
  final googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  RemoteDataSource();

  Future<Either<Failure, AccountEntity>> authWithGoogleAccount() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return const Left(FirebaseAuthFailure());

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        await auth.signInWithCredential(credential);
        logger.i("Successful authorization");
        final response = await getAccountEntity();
        return response.fold(
          (l) => Left(l),
          (r) => Right(r),
        );
      } on FirebaseAuthException catch (e) {
        rethrow;
      }
    } on FirebaseAuthException catch (e) {
      //not implemented yet
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

  Future<Either<Failure, AccountEntity>> getAccountEntity() async {
    AccountEntity accountEntity;
    try {
      if (auth.currentUser != null) {
        final userCollectionRef = firestore.collection("accounts");
        final uuid = auth.currentUser!.uid;

        final document = await userCollectionRef.doc(uuid).get();
        if (document.data() == null) {
          await userCollectionRef.doc(uuid).set({
            AccountFirestoreSchema.uuid: uuid,
            AccountFirestoreSchema.name: auth.currentUser!.displayName,
            AccountFirestoreSchema.imageLink: auth.currentUser!.photoURL,
          });
        }
        accountEntity = await userCollectionRef.doc(uuid).get().then((value) {
          return UserTableModel.fromSnapshot(value);
        });
        return Right(accountEntity);
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
      await auth.signOut();
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      return const Left(FirebaseAuthFailure());
    }
  }
}
