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
