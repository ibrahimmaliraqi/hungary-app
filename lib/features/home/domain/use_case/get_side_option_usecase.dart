import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';
import 'package:hungry_app/features/home/domain/repo/home_repo.dart';

class GetSideOptionUsecase {
  final HomeRepo homeRepo;

  GetSideOptionUsecase({required this.homeRepo});
  Future<Either<Failure, List<ProductOptionEntity>>> call({
    required int productId,
  }) {
    return homeRepo.getSideOptions(productId: productId);
  }
}
