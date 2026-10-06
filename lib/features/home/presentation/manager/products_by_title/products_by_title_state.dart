part of 'products_by_title_cubit.dart';

@immutable
sealed class ProductsByTitleState {}

final class ProductsByTitleInitial extends ProductsByTitleState {}

final class ProductsByTitleLoading extends ProductsByTitleState {}

final class ProductsByTitleSuccess extends ProductsByTitleState {
  final List<ProductEntity> products;

  ProductsByTitleSuccess({required this.products});
}

final class ProductsByTitleFailure extends ProductsByTitleState {
  final String errMessage;

  ProductsByTitleFailure({required this.errMessage});
}
