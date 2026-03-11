import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/product/data/repos/product_detils_repo.dart';
import 'package:meta/meta.dart';

import '../../models/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.productDetilsRepo) : super(CartInitial());
  final ProductDetilsRepo productDetilsRepo;

  Future<void> addItem({
    required CartModel cart,
    required String uid,
  }) async {
    emit(CartLoading());

    final result = await productDetilsRepo.addOrUpdateCart(
      userId: uid,
      cart: cart,
    );

    result.fold(
      (failure) => emit(CartFailure(failure.message)),
      (message) => emit(CartLoaded(cart)),
    );
  }
}
