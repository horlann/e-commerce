import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/bloc/account/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final _remoteRepository = RemoteRepositoryImpl(RemoteDataSource());

  AccountBloc() : super(const InProgressAuthState()) {
    on<InitAuthEvent>(_initAuth);
    on<AuthWithGoogleAccountEvent>(_authWithGoogleAccount);
    on<LogoutFromAccountEvent>(_logout);
  }

  void _initAuth(AccountEvent event, Emitter<AccountState> emit) async {
    final result = await _remoteRepository.getAccountEntity();
    result.fold(
      (l) => emit(state.unauthorized()),
      (r) => {emit(state.authorized(entity: r))},
    );
  }

  void _authWithGoogleAccount(AccountEvent event, Emitter<AccountState> emit) async {
    final result = await _remoteRepository.authWithGoogleAccount();
    result.fold(
      (l) => emit(state.unauthorized()),
      (r) => {emit(state.authorized(entity: r))},
    );
  }

  void _logout(AccountEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    final result = await _remoteRepository.logout();
    result.fold(
      (l) => emit(state.inProgress()), //change
      (r) => {emit(state.unauthorized())},
    );
  }
}
