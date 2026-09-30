import 'package:dartz/dartz.dart';
import 'package:hungry_app/core/error/app_exceptions.dart';
import 'package:hungry_app/core/error/failure.dart';
import 'package:hungry_app/features/cart/data/data_source/cart_data_source.dart';
import 'package:hungry_app/features/cart/data/model/cart_model.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/cart/domain/repo/cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final CartDataSource cartDataSource;

  CartRepoImpl({required this.cartDataSource});
  @override
  Future<Either<Failure, void>> addToCart({required CartEntity cart}) async {
    try {
      await cartDataSource.addToCart(
        cart: CartModel.fromEntity(cart),
      );
      return right(null);
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCartItems() async {
    try {
      final res = await cartDataSource.getCartItems();
      return right(res.map((e) => e.toEntity()).toList());
    } on AppExceptions catch (e) {
      return left(ServerFailure(message: e.errMessage));
    }
  }
}
