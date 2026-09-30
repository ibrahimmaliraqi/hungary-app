import 'package:bloc/bloc.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/cart/domain/use_cases/clear_cart_usecase.dart';
import 'package:hungry_app/features/cart/domain/use_cases/delete_item_from_cart_usecase.dart';
import 'package:hungry_app/features/cart/domain/use_cases/get_cart_items_usecase.dart';
import 'package:meta/meta.dart';

part 'get_cart_items_state.dart';

class GetCartItemsCubit extends Cubit<GetCartItemsState> {
  final GetCartItemsUsecase getCartItemsUsecase;
  final DeleteItemFromCartUsecase deleteItemFromCartUsecase;
  final ClearCartUsecase clearCartUsecase;
  GetCartItemsCubit({
    required this.getCartItemsUsecase,
    required this.deleteItemFromCartUsecase,
    required this.clearCartUsecase,
  }) : super(GetCartItemsInitial());

  Future getCartItem({required int userId}) async {
    emit(GetCartItemsLoading());
    final res = await getCartItemsUsecase.call(userId: userId);
    res.fold(
      (l) => emit(GetCartItemsFailure(errMessage: l.message)),
      (r) => emit(GetCartItemsSuccess(carts: r)),
    );
  }

  Future deleteItemFromCart({required int itemId, required int userId}) async {
    emit(GetCartItemsLoading());
    final res = await deleteItemFromCartUsecase.call(itemId: itemId);
    res.fold(
      (l) => emit(GetCartItemsFailure(errMessage: l.message)),
      (r) async {
        await getCartItem(userId: userId);
      },
    );
  }

  Future cleatCart({required int userId}) async {
    emit(GetCartItemsLoading());
    final res = await clearCartUsecase.call(userId: userId);
    res.fold(
      (l) => emit(GetCartItemsFailure(errMessage: l.message)),
      (r) async {
        await getCartItem(userId: PrefsHelper.getUser()!.id!);
      },
    );
  }
}
