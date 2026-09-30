import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/cart/domain/repo/cart_repo.dart';

class ClearCartUsecase {
  final CartRepo cartRepo;

  ClearCartUsecase({required this.cartRepo});
  Future<Either<Failure, void>> call({required int userId}) {
    return cartRepo.clearCart(userId: userId);
  }
}
