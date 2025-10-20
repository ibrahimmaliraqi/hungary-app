import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exception.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/core/utils/pref_helpers.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService _apiService = ApiService();
  Future<UserModel> login(String email, String password) async {
    try {
      final res = await _apiService.post("/login", {
        "email": email,
        "password": password,
      });
      final user = UserModel.fromJson(res);
      if (user.data?.token != null) {
        PrefHelpers.saveToken(user.data!.token!);
      }
      return user;
    } on DioException catch (e) {
      throw ApiException.errorHandler(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
