import 'package:dartz/dartz.dart';
import 'package:kurilki/common/failures/failures.dart';
import 'package:kurilki/domain/entities/remote/firebase/user_entity.dart';

abstract class RemoteRepository {
  const RemoteRepository();
  Future<Either<Failure, AccountEntity>> authWithGoogleAccount();

  Future<Either<Failure, AccountEntity>> getAccountEntity();

  Future<Either<Failure, bool>> logout();
}
