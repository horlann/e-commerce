import 'package:injectable/injectable.dart';
import 'package:kurilki/common/services/firebase.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseService> get fireService => FirebaseService.init();

// @singleton
// AppRouter get appRouter => AppRouter();
}
