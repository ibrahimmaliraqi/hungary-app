import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';
import 'package:hungry_app/features/auth/domain/repo/auth_repo.dart';

class UpdateUserUsecase {
  final AuthRepo authRepo;

  UpdateUserUsecase({required this.authRepo});
  Future<Either<Failure, UserEntity>> call({
    required UserEntity user,
  }) {
    return authRepo.updateProfileData(user: user);
  }
}
