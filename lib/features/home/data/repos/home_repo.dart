import 'package:dartz/dartz.dart';
import 'package:hungry_app/features/home/data/models/products_model.dart';

import '../../../../core/error/supabsae_failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductsModel>>> getProducts();
}
