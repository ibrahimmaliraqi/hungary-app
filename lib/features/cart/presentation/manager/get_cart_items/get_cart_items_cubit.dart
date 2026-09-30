import 'package:bloc/bloc.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hungry_app/features/cart/domain/use_cases/delete_item_from_cart_usecase.dart';
import 'package:hungry_app/features/cart/domain/use_cases/get_cart_items_usecase.dart';
import 'package:meta/meta.dart';

part 'get_cart_items_state.dart';

class GetCartItemsCubit extends Cubit<GetCartItemsState> {
  final GetCartItemsUsecase getCartItemsUsecase;
  final DeleteItemFromCartUsecase deleteItemFromCartUsecase;
  GetCartItemsCubit({
    required this.getCartItemsUsecase,
    required this.deleteItemFromCartUsecase,
  }) : super(GetCartItemsInitial());

  Future getCartItem({required int userId}) async {
    emit(GetCartItemsLoading());
    final res = await getCartItemsUsecase.call(userId: userId);
    res.fold(
      (l) => emit(GetCartItemsFailure(errMessage: l.message)),
      (r) => emit(GetCartItemsSuccess(carts: r)),
    );
  }

  Future deleteItemFromCart({required int itemId}) async {
    emit(GetCartItemsLoading());
    final res = await deleteItemFromCartUsecase.call(itemId: itemId);
    res.fold(
      (l) => emit(GetCartItemsFailure(errMessage: l.message)),
      (r) async {
        await getCartItem(userId: PrefsHelper.getUser()!.id!);
      },
    );
  }
}
