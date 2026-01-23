import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/supabsae_failure.dart';

abstract class AuthRepo {
  // Future<Either<Failure, UserModel>> login(String email, String password);
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
  // Future<Either<Failure, UserModel?>> getProfileData();
  // Future<Either<Failure, UserModel?>> updateProfileData({
  //   required String name,
  //   required String email,
  //   required String address,
  //   String? visa,
  //   String? imagePath,
  // });
}
