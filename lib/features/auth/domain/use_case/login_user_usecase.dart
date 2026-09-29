import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';
import 'package:hungry_app/features/auth/domain/repo/auth_repo.dart';

class LoginUserUsecase {
  final AuthRepo authRepo;

  LoginUserUsecase({required this.authRepo});
  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    return authRepo.login(email, password);
  }
}
