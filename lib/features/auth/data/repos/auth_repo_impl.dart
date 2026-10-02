import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/auth/data/data_source/auth_remote.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';
import 'package:hungry_app/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemote authRemote;

  AuthRepoImpl({required this.authRemote});
  @override
  Future<Either<Failure, UserEntity>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final res = await authRemote.register(name, email, password);

      return right(res.toEntity());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final res = await authRemote.login(email, password);

      return right(res.toEntity());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getProfileData({
    required String id,
  }) async {
    try {
      final res = await authRemote.getProfileData(id: id);

      return right(res?.toEntity());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfileData({
    required String name,
    required String id,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) {
    // TODO: implement updateProfileData
    throw UnimplementedError();
  }
}
