import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/cart/domain/use_cases/add_to_cart_usecase.dart';
import 'package:meta/meta.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final AddToCartUsecase addToCartUsecase;
  AddToCartCubit({required this.addToCartUsecase}) : super(AddToCartInitial());
  Future addToCart({required CartEntity cart}) async {
    emit(AddToCartLoading());
    final res = await addToCartUsecase.call(cart: cart);
    res.fold(
      (l) => emit(AddToCartFailure(errMessage: l.message)),
      (r) => emit(AddToCartSuccess()),
    );
  }
}
