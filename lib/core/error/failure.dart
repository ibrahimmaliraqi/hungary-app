import 'package:dio/dio.dart';

/// ✅ Base abstract class for all types of failures.
abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

/// 💥 Handles all server-related exceptions coming from Dio.
class ServerFailure extends Failure {
  const ServerFailure(super.errMessage);

  /// 🧩 Factory constructor to map Dio exceptions to user-friendly messages.
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure("⏱ Connection timeout. Please try again.");

      case DioExceptionType.sendTimeout:
        return const ServerFailure(
          "📡 Sending timeout. Please check your network.",
        );

      case DioExceptionType.receiveTimeout:
        return const ServerFailure("⏳ Server took too long to respond.");

      case DioExceptionType.badCertificate:
        return const ServerFailure(
          "⚠️ Invalid server certificate. Please try later.",
        );

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode ?? 0,
          dioException.response?.data,
        );

      case DioExceptionType.cancel:
        return const ServerFailure("❌ Request was cancelled.");

      case DioExceptionType.connectionError:
        return const ServerFailure(
          "🌐 Network connection error. Check your internet.",
        );

      case DioExceptionType.unknown:
        if (dioException.message?.contains("SocketException") ?? false) {
          return const ServerFailure("📶 No internet connection.");
        }
        return const ServerFailure(
          "🚨 Unexpected error. Please try again later.",
        );
    }
  }

  /// 🧾 Factory constructor to handle API response errors.
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 404) {
      final message = response is Map && response['message'] != null
          ? response['message'].toString()
          : "⚠️ Request error ($statusCode). Please check your input.";
      return ServerFailure(message);
    } else if (statusCode == 500) {
      return const ServerFailure(
        "💥 Internal server error. Please try again later.",
      );
    } else {
      return const ServerFailure(
        "❗ Oops! Something went wrong. Please try again.",
      );
    }
  }
}
