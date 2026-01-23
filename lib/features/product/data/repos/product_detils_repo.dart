import 'package:dartz/dartz.dart';
import 'package:hungry_app/features/product/data/models/toppings_model.dart';

import '../../../../core/error/supabsae_failure.dart';

abstract class ProductDetilsRepo {
  Future<Either<Failure, List<ToppingsModel>>> getToppings();
  Future<Either<Failure, List<ToppingsModel>>> getSideOption();
}
