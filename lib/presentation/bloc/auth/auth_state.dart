import 'package:google_sign_in/google_sign_in.dart';

class AuthState {
  const AuthState();

  AuthState authorized({required GoogleSignInAccount user}) {
    return AuthorizedState(user);
  }

  AuthState unauthorizedState() {
    return const UnauthorizedState();
  }
}

class AuthorizedState extends AuthState {
  final GoogleSignInAccount user;

  const AuthorizedState(this.user);
}

class UnauthorizedState extends AuthState {
  const UnauthorizedState();
}
