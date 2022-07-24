import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/common/services/firebase.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseService> get fireService => FirebaseService.init();

  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
}
