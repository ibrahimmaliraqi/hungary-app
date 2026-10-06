import 'package:dartz/dartz.dart';
import 'package:hungry_app/features/home/domain/entities/category_entity.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';

import '../../../../core/error/failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<ProductOptionEntity>>> getToppings({
    required int productId,
  });
  Future<Either<Failure, List<ProductOptionEntity>>> getSideOptions({
    required int productId,
  });
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory({
    required int categoryId,
  });
}
