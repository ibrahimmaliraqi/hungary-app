import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/home/data/models/products_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductsModel>>> getProducts();
}
