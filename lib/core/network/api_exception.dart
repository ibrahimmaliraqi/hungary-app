import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';

class ApiException {
  static ApiError errorHandler(DioException error) {
    String message = "An unknown error occurred.";
    int? statusCode;

    switch (error.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled.";
        break;

      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server.";
        break;

      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server.";
        break;

      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server.";
        break;

      case DioExceptionType.badResponse:
        // معالجة الأخطاء التي تأتي مع استجابة HTTP (مثل 404, 500)
        final response = error.response;
        statusCode = response?.statusCode;

        if (statusCode != null) {
          if (statusCode >= 400 && statusCode < 500) {
            // أخطاء العميل (مثل 401 Unauthorised, 404 Not Found)
            // محاولة استخراج رسالة من الـ response data
            // (قد تحتاج لتعديل key 'message' حسب تنسيق الـ API)
            message =
                response?.data['message'] ?? "Client error: Status $statusCode";
          } else if (statusCode >= 500) {
            // أخطاء الخادم (مثل 500 Internal Server Error)
            message = "Server-side error: Status $statusCode";
          } else {
            message = "Received bad response with status code: $statusCode";
          }
        } else {
          message = "Received an unexpected bad response from server.";
        }
        break;

      case DioExceptionType.connectionError:
        // خطأ الاتصال بالشبكة أو فشل البحث عن الخادم
        message =
            "Connection error. Check your internet connection or server address.";
        break;

      case DioExceptionType.badCertificate:
        // مشكلة في شهادة SSL/TLS
        message = "Bad SSL certificate error. Validation failed.";
        break;

      case DioExceptionType.unknown:
      default:
        // لأي استثناءات أخرى غير مغطاة
        message = error.message ?? "An unexpected error occurred.";
        break;
    }

    return ApiError(message: message);
  }
}
