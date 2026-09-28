import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: "http://hungry-ecommerce.onlinewebshop.net/",
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
  }) async {
    final response = await _dio.post(
      path,
      data: data,
    );

    return response.data;
  }
}
