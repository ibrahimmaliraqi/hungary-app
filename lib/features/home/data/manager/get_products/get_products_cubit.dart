import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/home/data/models/products_model.dart';
import 'package:hungry_app/features/home/data/repos/home_repo.dart';
import 'package:meta/meta.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit(this.homeRepo) : super(GetProductsInitial());
  HomeRepo homeRepo;
  Future getProduct() async {
    emit(GetProductsLoading());
    final result = await homeRepo.getProducts();
    result.fold(
      (fail) {
        emit(GetProductsFailure(fail.errMessage));
      },
      (products) {
        emit(GetProductsSuccess(products));
      },
    );
  }
}
