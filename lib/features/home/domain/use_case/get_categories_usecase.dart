import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/home/domain/entities/category_entity.dart';
import 'package:hungry_app/features/home/domain/repo/home_repo.dart';

class GetCategoriesUsecase {
  final HomeRepo homeRepo;

  GetCategoriesUsecase({required this.homeRepo});
  Future<Either<Failure, List<CategoryEntity>>> call() {
    return homeRepo.getCategories();
  }
}
