class ServerException implements Exception {
  final String? message;
  final String code;

  ServerException({required this.message, required this.code});
  factory ServerException.unknown() {
    return ServerException(message: 'Unknown Error', code: '');
  }
  String get getErrorMessage {
    return message ?? "Unknown Error";
  }
}

class FirebaseSignInServerException extends ServerException {
  FirebaseSignInServerException({required super.message, required super.code});
  @override
  String get getErrorMessage {
    print(code);
    print(message);
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'The user has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'The email is already in use.';
      case 'operation-not-allowed':
        return 'Operation not allowed.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'invalid-credential':
        return 'The supplied auth credential is malformed or has expired.';

      default:
        return 'An unknown error occurred';
    }
  }
}

class FirebaseFirestoreServerException extends ServerException {
  FirebaseFirestoreServerException(
      {required super.message, required super.code});
  @override
  String get getErrorMessage {
    switch (code) {
      case 'permission-denied':
        return 'Permission denied.';
      case 'not-found':
        return 'Document not found.';
      case 'already-exists':
        return 'Document already exists.';
      case 'invalid-argument':
        return 'Invalid argument provided.';
      case 'deadline-exceeded':
        return 'Operation took too long.';
      case 'resource-exhausted':
        return 'Resource exhausted.';
      case 'failed-precondition':
        return 'Failed precondition.';
      case 'aborted':
        return 'Operation aborted.';
      case 'out-of-range':
        return 'Operation out of range.';
      case 'unimplemented':
        return 'Operation not implemented.';
      case 'internal':
        return 'Internal Firestore error.';
      case 'unavailable':
        return 'Firestore service unavailable.';
      case 'data-loss':
        return 'Data loss or corruption.';
      case 'unauthenticated':
        return 'User not authenticated.';
      default:
        return 'An unknown error occurred: ';
    }
  }
}

class CacheException implements Exception {
  final String message;
  CacheException({required this.message});

  factory CacheException.unknown() {
    return CacheException(
      message: '',
    );
  }
  factory CacheException.noData() {
    return CacheException(
      message: 'No Data',
    );
  }

  String get getErrorMessage {
    return message;
  }
}

