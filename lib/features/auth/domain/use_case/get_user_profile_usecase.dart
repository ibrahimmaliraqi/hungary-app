import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';
import 'package:hungry_app/features/auth/domain/repo/auth_repo.dart';

class GetUserProfileUsecase {
  final AuthRepo authRepo;

  GetUserProfileUsecase({required this.authRepo});
  Future<Either<Failure, UserEntity?>> call({required String id}) {
    return authRepo.getProfileData(id: id);
  }
}
