import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/product/data/models/toppings_model.dart';

abstract class ProductDetilsRepo {
  Future<Either<Failure, List<ToppingsModel>>> getToppings();
  Future<Either<Failure, List<ToppingsModel>>> getSideOption();
}
