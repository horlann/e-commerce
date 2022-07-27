import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class InitAuthEvent extends AccountEvent {
  const InitAuthEvent();
}

class AuthWithGoogleAccountEvent extends AccountEvent {
  const AuthWithGoogleAccountEvent();
}

class LogoutFromAccountEvent extends AccountEvent {
  const LogoutFromAccountEvent();
}
