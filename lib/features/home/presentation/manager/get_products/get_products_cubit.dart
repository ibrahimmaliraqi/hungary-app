import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/domain/use_case/get_products_usecase.dart';
import 'package:meta/meta.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  final GetProductsUsecase getProductsUsecase;
  GetProductsCubit({required this.getProductsUsecase})
    : super(GetProductsInitial());
  Future getProduct() async {
    emit(GetProductsLoading());
    final result = await getProductsUsecase.call();
    result.fold(
      (fail) {
        emit(GetProductsFailure(fail.message));
      },
      (products) {
        emit(GetProductsSuccess(products));
      },
    );
  }
}
