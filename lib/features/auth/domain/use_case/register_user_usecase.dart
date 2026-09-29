import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';
import 'package:hungry_app/features/auth/domain/repo/auth_repo.dart';

class RegisterUserUsecase {
  final AuthRepo authRepo;

  RegisterUserUsecase({required this.authRepo});

  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return authRepo.register(name, email, password);
  }
}
