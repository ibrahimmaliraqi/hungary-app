import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  ApiService apiService = ApiService();
  @override
  Future<Either<Failure, UserModel>> login(
    String email,
    String password,
  ) async {
    try {
      final res = await apiService.post("/login", {
        "email": email,
        "password": password,
      });
      UserModel user = UserModel.fromJson(res);
      return right(user);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final res = await apiService.post("/register", {
        "name": name,
        "email": email,
        "password": password,
      });
      UserModel user = UserModel.fromJson(res);
      return right(user);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
