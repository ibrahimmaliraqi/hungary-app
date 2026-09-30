import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepo {
  Future<Either<Failure, void>> addToCart({required CartEntity cart});
  Future<Either<Failure, List<CartEntity>>> getCartItems();
}
