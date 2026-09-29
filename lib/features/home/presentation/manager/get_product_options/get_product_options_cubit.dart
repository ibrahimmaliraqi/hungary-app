import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/home/domain/entities/product_option_entity.dart';
import 'package:hungry_app/features/home/domain/use_case/get_side_option_usecase.dart';
import 'package:hungry_app/features/home/domain/use_case/get_toppings_usecase.dart';
import 'package:meta/meta.dart';

part 'get_product_options_state.dart';

class GetProductOptionsCubit extends Cubit<GetProductOptionsState> {
  final GetToppingsUsecase getToppingsUsecase;
  final GetSideOptionUsecase getSideOptionUsecase;

  GetProductOptionsCubit({
    required this.getToppingsUsecase,
    required this.getSideOptionUsecase,
  }) : super(GetProductOptionsInitial());
  Future getToppings({required int productId}) async {
    emit(GetProductOptionsLoading());
    final result = await getToppingsUsecase.call(productId: productId);
    result.fold(
      (fail) {
        emit(GetProductOptionsFailure(errMessage: fail.message));
      },
      (topping) {
        emit(GetProductOptionsSuccess(options: topping));
      },
    );
  }

  Future getSideOptions({required int productId}) async {
    emit(GetProductOptionsLoading());
    final result = await getSideOptionUsecase.call(productId: productId);
    result.fold(
      (fail) {
        emit(GetProductOptionsFailure(errMessage: fail.message));
      },
      (sideOption) {
        emit(GetProductOptionsSuccess(options: sideOption));
      },
    );
  }
}
