// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasources/remote_datasource.dart' as _i7;
import '../../data/repositories/admin/remote_admin_repositiory.dart' as _i10;
import '../../data/repositories/remote_repository.dart' as _i8;
import '../../presentation/bloc/account/account_bloc.dart' as _i9;
import '../services/connection/custom_connection_checker.dart' as _i3;
import '../services/firebase.dart' as _i6;
import 'app_module.dart' as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get, {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.lazySingleton<_i3.CustomConnectionChecker>(() => _i3.CustomConnectionChecker());
  gh.lazySingleton<_i4.FirebaseAuth>(() => appModule.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(() => appModule.firebaseFirestore);
  await gh.factoryAsync<_i6.FirebaseService>(() => appModule.fireService, preResolve: true);
  gh.lazySingleton<_i7.RemoteDataSource>(
      () => _i7.RemoteDataSource(get<_i5.FirebaseFirestore>(), get<_i4.FirebaseAuth>()));
  gh.lazySingleton<_i8.RemoteRepository>(() => _i8.RemoteRepository(get<_i7.RemoteDataSource>()));
  gh.factory<_i9.AccountBloc>(() => _i9.AccountBloc(get<_i8.RemoteRepository>()));
  gh.lazySingleton<_i10.RemoteAdminRepository>(() => _i10.RemoteAdminRepository(get<_i7.RemoteDataSource>()));
  return get;
}

class _$AppModule extends _i11.AppModule {}
