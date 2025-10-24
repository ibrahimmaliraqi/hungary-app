import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login(String email, String password);
  Future<Either<Failure, UserModel>> register(
    String name,
    String email,
    String password,
  );
  Future<Either<Failure, UserModel?>> getProfileData();
  Future<Either<Failure, UserModel?>> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  });
}
