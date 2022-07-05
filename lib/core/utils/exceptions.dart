class CustomException implements Exception {
  final String message;

  CustomException({
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}

class ServerException extends CustomException {
  ServerException({required String message}) : super(message: message);
}

class CacheException extends CustomException {
  CacheException({required String message}) : super(message: message);
}

class LocalException extends CustomException {
  LocalException({required String message}) : super(message: message);
}
