part of 'get_product_options_cubit.dart';

@immutable
sealed class GetProductOptionsState {}

final class GetProductOptionsInitial extends GetProductOptionsState {}

final class GetProductOptionsLoading extends GetProductOptionsState {}

final class GetProductOptionsSuccess extends GetProductOptionsState {
  final List<ProductOptionEntity> toppings;
  final List<ProductOptionEntity> sideOptions;

  GetProductOptionsSuccess({
    required this.toppings,
    required this.sideOptions,
  });
}

final class GetProductOptionsFailure extends GetProductOptionsState {
  final String errMessage;

  GetProductOptionsFailure({
    required this.errMessage,
  });
}
