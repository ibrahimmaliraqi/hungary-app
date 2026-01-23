import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/supabsae_failure.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, dynamic>> login(String email, String password);
  Future<Either<Failure, String>> register(
    String name,
    String email,
    String password,
  );
  Future saveUserData(
    String name,
    String email,
    String uId,
  );
  Future<Either<Failure, UserModel?>> getProfileData({required String uId});
  Future<Either<Failure, dynamic>> updateProfileData({
    required String name,
    required String uId,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  });
}
