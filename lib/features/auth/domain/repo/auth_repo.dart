import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register(
    String name,
    String email,
    String password,
  );
  Future<void> saveUserData({required UserEntity user});
  Future<Either<Failure, UserEntity>> updateProfileData({
    required String name,
    required String id,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  });
}
