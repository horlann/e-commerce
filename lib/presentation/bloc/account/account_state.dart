import 'package:kurilki/domain/entities/user/user_entity.dart';

class AccountState {
  const AccountState();

  AccountState authorized({required UserEntity entity}) {
    return AuthorizedState(entity);
  }

  AccountState unauthorized() {
    return const UnauthorizedState();
  }

  AccountState inProgress() {
    return const InProgressAuthState();
  }

  AccountState failure() {
    return const AuthorizationFailureState();
  }

  AccountState userDataLoaded(UserEntity user) {
    return UserDataLoaded(user);
  }
}

class AuthorizedState extends AccountState {
  final UserEntity entity;

  const AuthorizedState(this.entity);
}

class InProgressAuthState extends AccountState {
  const InProgressAuthState();
}

class UnauthorizedState extends AccountState {
  const UnauthorizedState();
}

class AuthorizationFailureState extends AccountState {
  const AuthorizationFailureState();
}

class UserDataLoaded extends AuthorizedState {
  const UserDataLoaded(this.user) : super(user);

  final UserEntity user;
}
