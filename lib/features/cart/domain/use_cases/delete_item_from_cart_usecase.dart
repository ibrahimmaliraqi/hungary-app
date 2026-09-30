import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/cart/domain/repo/cart_repo.dart';

class DeleteItemFromCartUsecase {
  final CartRepo cartRepo;

  DeleteItemFromCartUsecase({required this.cartRepo});
  Future<Either<Failure, void>> call({required int itemId}) {
    return cartRepo.deleteItemFromCart(itemId: itemId);
  }
}
