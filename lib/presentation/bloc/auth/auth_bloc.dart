import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/data/datasources/remote_datasource.dart';
import 'package:kurilki/presentation/bloc/auth/auth_event.dart';
import 'package:kurilki/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final remoteDataSource = RemoteDataSource();
  AuthBloc() : super(const UnauthorizedState()) {
    //on<InitAuthEvent>((event, emit) => _initAuth);
    on<AuthWithGoogleAccountEvent>(_authWithGoogleAccount);
  }

  //void _initAuth() {}

  void _authWithGoogleAccount(AuthEvent event, Emitter<AuthState> emit) async {
    final result = await remoteDataSource.authWithGoogleAccount();
    result.fold(
      (l) {
        emit(state.unauthorizedState());
      },
      (r) {
        emit(state.authorized(user: r));
      },
    );
  }
}
