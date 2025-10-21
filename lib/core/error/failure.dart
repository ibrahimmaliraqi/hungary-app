import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Api coneecion is timeout");
      case DioExceptionType.sendTimeout:
        return ServerFailure("Api coneecion is sendtimeout");

      case DioExceptionType.receiveTimeout:
        return ServerFailure("Api coneecion is receivedTimeout");

      case DioExceptionType.badCertificate:
        return ServerFailure("Api coneecion is badCertificate");

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure("Api coneecion was cancled");

      case DioExceptionType.connectionError:
        return ServerFailure("Api coneecion was connectionError");

      case DioExceptionType.unknown:
        if (dioException.message!.contains("SocketException")) {
          return ServerFailure("no internet connection");
        }
        return ServerFailure("Unexcpected error, please try later");
      // default:
      //   return ServerFailure("Opps, there is an error ,please try again later");
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic resopnse) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(resopnse["error"]['message']);
    } else if (statusCode == 404) {
      return ServerFailure("your request not found ,please try again!");
    } else if (statusCode == 500) {
      return ServerFailure("internal error ,please try again later!");
    } else {
      return ServerFailure("Opps, there is an error ,please try again later");
    }
  }
}
