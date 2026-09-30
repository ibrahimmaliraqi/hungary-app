import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/cart/domain/repo/cart_repo.dart';

class GetCartItemsUsecase {
  final CartRepo cartRepo;

  GetCartItemsUsecase({required this.cartRepo});
  Future<Either<Failure, List<CartEntity>>> call() {
    return cartRepo.getCartItems();
  }
}
