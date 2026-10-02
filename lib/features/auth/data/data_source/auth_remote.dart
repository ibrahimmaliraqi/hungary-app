import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/core/network/dio_client.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';

abstract class AuthRemote {
  Future<UserModel> login(String email, String password);

  Future<UserModel> register(
    String name,
    String email,
    String password,
  );
}

class ApiAuthRemoteImpl implements AuthRemote {
  final DioClient dioClient;

  ApiAuthRemoteImpl({
    required this.dioClient,
  });

  @override
  Future<UserModel> login(
    String email,
    String password,
  ) async {
    try {
      final res = await dioClient.post(
        "auth/login.php",
        data: {
          "email": email,
          "password": password,
        },
      );

      if (res['success'] == true) {
        return UserModel.fromMap(res['data']);
      }

      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء تسجيل الدخول",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        errMessage: "حدث خطأ أثناء تسجيل الدخول",
      );
    }
  }

  @override
  Future<UserModel> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final res = await dioClient.post(
        "auth/create_account.php",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "image": "",
          "address": "Baghdad",
          "visa": "",
        },
      );

      if (res['success'] == true) {
        return UserModel.fromMap(res['data']);
      }

      throw ServerException(
        errMessage: res['message'] ?? "حدث خطأ أثناء إنشاء الحساب",
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      print("eeeeeeeeeeeeee: $e");
      throw ServerException(
        errMessage: "حدث خطأ أثناء إنشاء الحساب",
      );
    }
  }
}
