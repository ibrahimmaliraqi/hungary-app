import 'package:dartz/dartz.dart';
import 'package:hungry_app/features/product/data/models/toppings_model.dart';

import '../../../../core/error/supabsae_failure.dart';
import '../models/cart_model.dart';

abstract class ProductDetilsRepo {
  Future<Either<Failure, List<ToppingsModel>>> getToppings();
  Future<Either<Failure, List<ToppingsModel>>> getSideOption();
  Future<Either<Failure, dynamic>> addOrUpdateCart({
    required String userId,
    required CartModel cart,
  });
}
