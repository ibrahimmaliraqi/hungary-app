import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/product/data/models/toppings_model.dart';
import 'package:hungry_app/features/product/data/repos/product_detils_repo.dart';
import 'package:meta/meta.dart';

part 'side_options_state.dart';

class SideOptionsCubit extends Cubit<SideOptionsState> {
  SideOptionsCubit(this.productDetils) : super(SideOptionsInitial());
  ProductDetilsRepo productDetils;
  Future getSideOptions() async {
    emit(SideOptionsLoading());
    final result = await productDetils.getSideOption();
    result.fold(
      (fail) {
        emit(SideOptionsFailure(fail.errMessage));
      },
      (sideOption) {
        emit(SideOptionsSuccess(sideOption));
      },
    );
  }
}
