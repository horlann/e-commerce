import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/bloc/account/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AuthState> {
  final remoteDataSource = RemoteDataSource();
  AccountBloc() : super(const UnauthorizedState()) {
    //on<InitAuthEvent>((event, emit) => _initAuth);
    on<AuthWithGoogleAccountEvent>(_authWithGoogleAccount);
    on<LogoutFromAccountEvent>(_logout);
  }

  //void _initAuth() {}

  void _authWithGoogleAccount(AccountEvent event, Emitter<AuthState> emit) async {
    final result = await remoteDataSource.authWithGoogleAccount();
    result.fold(
      (l) => emit(state.unauthorized()),
      (r) => emit(state.authorized(user: r)),
    );
  }

  void _logout(AccountEvent event, Emitter<AuthState> emit) async {
    await remoteDataSource.logout();
  }
}
