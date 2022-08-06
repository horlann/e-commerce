import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/data/repositories/user/user_remote_repository.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/bloc/account/account_state.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRemoteRepository _userRemoteRepository;

  AccountBloc(this._userRemoteRepository) : super(const UnauthorizedState()) {
    on<InitAuthEvent>(_initAuth);
    on<AuthWithGoogleAccountEvent>(_authWithGoogleAccount);
    on<LogoutFromAccountEvent>(_logout);
  }

  Future<void> _initAuth(AccountEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      final result = await _userRemoteRepository.getAccountEntity();
      emit(state.authorized(entity: result));
    } on Exception {
      emit(state.unauthorized());
    }
  }

  Future<void> _authWithGoogleAccount(AccountEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      final result = await _userRemoteRepository.authWithGoogleAccount();
      emit(state.authorized(entity: result));
    } on Exception {
      emit(state.failure());
    }
  }

  Future<void> _logout(AccountEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      await _userRemoteRepository.logout();
      emit(state.unauthorized());
    } on Exception {
      emit(state.failure());
    }
  }
}
