import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

//class InitAuthEvent extends AuthEvent {}

class AuthWithGoogleAccountEvent extends AccountEvent {}

class LogoutFromAccountEvent extends AccountEvent {}
