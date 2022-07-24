import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kurilki/common/failures/failures.dart';

class RemoteDataSource {
  final googleSignIn = GoogleSignIn();

  Future<Either<Failure, GoogleSignInAccount>> authWithGoogleAccount() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return const Left(FirebaseAuthFailure());

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    return Right(googleUser);
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
