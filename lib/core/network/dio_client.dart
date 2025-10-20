import 'package:dio/dio.dart';
import 'package:hungry_app/core/utils/pref_helpers.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://sonic-zdi0.onrender.com/api",
      headers: {"Content-Type": "application/json"},
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String? token = await PrefHelpers.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );
  }
  Dio get dio => _dio;
}
