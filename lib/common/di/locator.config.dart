// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../../data/datasources/remote_datasource.dart' as _i7;
import '../../data/datasources/shards_datasource.dart' as _i12;
import '../../data/repositories/admin/remote_admin_repositiory.dart' as _i15;
import '../../data/repositories/local_repository.dart' as _i13;
import '../../data/repositories/ordering/ordering_remote_repository.dart'
    as _i14;
import '../../data/repositories/remote_repository.dart' as _i8;
import '../../data/repositories/user/user_remote_repository.dart' as _i10;
import '../../presentation/bloc/account/account_bloc.dart' as _i11;
import '../services/connection/custom_connection_checker.dart' as _i3;
import '../services/firebase.dart' as _i6;
import 'app_module.dart' as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.lazySingleton<_i3.CustomConnectionChecker>(
      () => _i3.CustomConnectionChecker());
  gh.lazySingleton<_i4.FirebaseAuth>(() => appModule.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(() => appModule.firebaseFirestore);
  await gh.factoryAsync<_i6.FirebaseService>(
    () => appModule.fireService,
    preResolve: true,
  );
  gh.lazySingleton<_i7.RemoteDataSource>(() => _i7.RemoteDataSource(
        get<_i5.FirebaseFirestore>(),
        get<_i4.FirebaseAuth>(),
      ));
  gh.lazySingleton<_i8.RemoteRepository>(
      () => _i8.RemoteRepository(get<_i7.RemoteDataSource>()));
  gh.lazySingletonAsync<_i9.SharedPreferences>(() => appModule.shards);
  gh.lazySingleton<_i10.UserRemoteRepository>(
      () => _i10.UserRemoteRepository(get<_i7.RemoteDataSource>()));
  gh.factory<_i11.AccountBloc>(
      () => _i11.AccountBloc(get<_i10.UserRemoteRepository>()));
  gh.singletonAsync<_i12.IKeyValueDataSource>(() async =>
      _i12.ShardsDataSource(await get.getAsync<_i9.SharedPreferences>()));
  gh.singletonAsync<_i13.LocalRepository>(() async =>
      _i13.LocalRepository(await get.getAsync<_i12.IKeyValueDataSource>()));
  gh.lazySingleton<_i14.OrderingRemoteRepository>(
      () => _i14.OrderingRemoteRepository(get<_i7.RemoteDataSource>()));
  gh.lazySingleton<_i15.RemoteAdminRepository>(
      () => _i15.RemoteAdminRepository(get<_i7.RemoteDataSource>()));
  return get;
}

class _$AppModule extends _i16.AppModule {}
