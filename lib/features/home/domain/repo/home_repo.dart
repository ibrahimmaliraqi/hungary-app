import 'package:dartz/dartz.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';

import '../../../../core/error/failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
