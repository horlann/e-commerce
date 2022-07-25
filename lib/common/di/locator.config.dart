// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasources/remote_datasource.dart' as _i5;
import '../../data/repositories/remote_repository.dart' as _i6;
import '../services/firebase.dart' as _i4;
import 'app_module.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get, {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.lazySingleton<_i3.FirebaseFirestore>(() => appModule.firebaseFirestore);
  await gh.factoryAsync<_i4.FirebaseService>(() => appModule.fireService, preResolve: true);
  gh.lazySingleton<_i5.RemoteDataSource>(() => _i5.RemoteDataSource(get<_i3.FirebaseFirestore>()));
  gh.singleton<_i6.RemoteRepository>(_i6.RemoteRepository(get<_i5.RemoteDataSource>()));
  return get;
}

class _$AppModule extends _i7.AppModule {}
