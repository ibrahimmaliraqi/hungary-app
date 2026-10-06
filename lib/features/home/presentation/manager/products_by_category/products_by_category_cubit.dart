import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/domain/use_case/get_products_by_category_usecase.dart';
import 'package:meta/meta.dart';

part 'products_by_category_state.dart';

class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase;
  ProductsByCategoryCubit({required this.getProductsByCategoryUsecase})
    : super(ProductsByCategoryInitial());
  Future getProductsByCategory({required int categoryId}) async {
    emit(ProductsByCategoryLoading());
    final res = await getProductsByCategoryUsecase.call(categoryId: categoryId);
    res.fold(
      (l) => emit(ProductsByCategoryFailure(errMessage: l.message)),
      (r) => emit(ProductsByCategorySuccess(products: r)),
    );
  }
}
