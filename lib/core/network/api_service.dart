import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_exception.dart';
import 'package:hungry_app/core/network/dio_client.dart';

class ApiService {
  DioClient _dioClient = DioClient();

  Future<dynamic> get(String endPoint) async {
    try {
      final res = await _dioClient.dio.get(endPoint);
      return res.data;
    } on DioException catch (e) {
      ApiException.errorHandler(e);
    }
  }

  Future<dynamic> post(String endPoint, Map<String, dynamic> body) async {
    try {
      final res = await _dioClient.dio.post(endPoint, data: body);
      return res.data;
    } on DioException catch (e) {
      ApiException.errorHandler(e);
    }
  }

  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final res = await _dioClient.dio.put(endPoint, data: body);
      return res.data;
    } on DioException catch (e) {
      ApiException.errorHandler(e);
    }
  }

  Future<dynamic> delete(String endPoint, Map<String, dynamic> body) async {
    try {
      final res = await _dioClient.dio.delete(endPoint, data: body);
      return res.data;
    } on DioException catch (e) {
      ApiException.errorHandler(e);
    }
  }
}
