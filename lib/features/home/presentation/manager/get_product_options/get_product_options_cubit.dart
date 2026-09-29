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

  List<ProductOptionEntity> toppings = [];
  List<ProductOptionEntity> sideOptions = [];

  Future<void> getProductOptions({
    required int productId,
  }) async {
    emit(GetProductOptionsLoading());

    final toppingsResult = await getToppingsUsecase.call(
      productId: productId,
    );

    final sideOptionsResult = await getSideOptionUsecase.call(
      productId: productId,
    );

    toppingsResult.fold(
      (fail) {
        print("Toppings Error: ${fail.message}");

        emit(
          GetProductOptionsFailure(
            errMessage: fail.message,
          ),
        );
      },
      (toppingsData) {
        print("Toppings Success: ${toppingsData.length}");

        toppings = toppingsData;

        sideOptionsResult.fold(
          (fail) {
            print("Side Options Error: ${fail.message}");

            emit(
              GetProductOptionsFailure(
                errMessage: fail.message,
              ),
            );
          },
          (sideOptionsData) {
            print("Side Options Success: ${sideOptionsData.length}");

            sideOptions = sideOptionsData;

            emit(
              GetProductOptionsSuccess(
                toppings: toppings,
                sideOptions: sideOptions,
              ),
            );
          },
        );
      },
    );
  }
}
