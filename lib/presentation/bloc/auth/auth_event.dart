import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

//class InitAuthEvent extends AuthEvent {}

class AuthWithGoogleAccountEvent extends AuthEvent {}
