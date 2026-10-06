import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/domain/use_case/get_products_by_title_usecase.dart';
import 'package:meta/meta.dart';

part 'products_by_title_state.dart';

class ProductsByTitleCubit extends Cubit<ProductsByTitleState> {
  final GetProductsByTitleUsecase getProductsByTitleUsecase;
  ProductsByTitleCubit({required this.getProductsByTitleUsecase})
    : super(ProductsByTitleInitial());
  Future getProductsByTitle({required String query}) async {
    emit(ProductsByTitleLoading());
    final res = await getProductsByTitleUsecase.call(query: query);
    res.fold(
      (l) => emit(ProductsByTitleFailure(errMessage: l.message)),
      (r) => emit(ProductsByTitleSuccess(products: r)),
    );
  }
}
