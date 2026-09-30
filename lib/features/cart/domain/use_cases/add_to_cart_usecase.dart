import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/cart/domain/repo/cart_repo.dart';

class AddToCartUsecase {
  final CartRepo cartRepo;

  AddToCartUsecase({required this.cartRepo});
  Future<Either<Failure, void>> call({required CartEntity cart}) {
    return cartRepo.addToCart(cart: cart);
  }
}
