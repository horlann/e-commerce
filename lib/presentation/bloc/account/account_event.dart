import 'package:equatable/equatable.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/user_data.dart';

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

class LoadDataEvent extends AccountEvent {
  const LoadDataEvent();
}

class SaveDataEvent extends AccountEvent {
  const SaveDataEvent({required this.userData});

  final UserData userData;
}
