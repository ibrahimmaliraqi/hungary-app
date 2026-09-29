abstract class AppExceptions implements Exception {
  final String errMessage;

  AppExceptions({required this.errMessage});
  @override
  String toString() {
    return errMessage;
  }
}

class ServerException extends AppExceptions {
  ServerException({required super.errMessage});
}
