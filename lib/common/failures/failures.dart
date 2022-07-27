abstract class Failure {
  const Failure();
}

class FirebaseAuthFailure extends Failure {
  const FirebaseAuthFailure();
}

class FirebaseUnknownFailure extends Failure {
  const FirebaseUnknownFailure();
}

class FirebaseForbiddenAccessFailure extends Failure {
  const FirebaseForbiddenAccessFailure();
}

class FirebaseOtherFailure extends Failure {
  const FirebaseOtherFailure();
}

