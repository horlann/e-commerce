import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/domain/entities/remote/firebase/user_entity.dart';
import 'package:kurilki/common/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kurilki/domain/repositories/remote/remote_repository.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final RemoteDataSource dataSource;

  RemoteRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, AccountEntity>> authWithGoogleAccount() async {
    return await dataSource.authWithGoogleAccount();
  }

  @override
  Future<Either<Failure, AccountEntity>> getAccountEntity() async {
    return await dataSource.getAccountEntity();
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    return await dataSource.logout();
  }
}
