import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/domain/repo/home_repo.dart';

class GetProductsByCategoryUsecase {
  final HomeRepo homeRepo;

  GetProductsByCategoryUsecase({required this.homeRepo});
  Future<Either<Failure, List<ProductEntity>>> call({
    required int categoryId,
  }) {
    return homeRepo.getProductsByCategory(categoryId: categoryId);
  }
}
