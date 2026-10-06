part of 'products_by_category_cubit.dart';

@immutable
sealed class ProductsByCategoryState {}

final class ProductsByCategoryInitial extends ProductsByCategoryState {}

final class ProductsByCategoryLoading extends ProductsByCategoryState {}

final class ProductsByCategorySuccess extends ProductsByCategoryState {
  final List<ProductEntity> products;

  ProductsByCategorySuccess({required this.products});
}

final class ProductsByCategoryFailure extends ProductsByCategoryState {
  final String errMessage;

  ProductsByCategoryFailure({required this.errMessage});
}
