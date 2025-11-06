import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/product/data/models/toppings_model.dart';
import 'package:hungry_app/features/product/data/repos/product_detils_repo.dart';
import 'package:meta/meta.dart';

part 'toppings_state.dart';

class ToppingsCubit extends Cubit<ToppingsState> {
  ToppingsCubit(this.productDetilsRepo) : super(ToppingsInitial());

  ProductDetilsRepo productDetilsRepo;
  Future getToppings() async {
    emit(ToppingsLoading());
    final result = await productDetilsRepo.getToppings();
    result.fold(
      (fail) {
        emit(ToppingsFailure(fail.errMessage));
      },
      (topping) {
        emit(ToppingsSuccess(topping));
      },
    );
  }
}
