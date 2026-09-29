part of 'get_product_options_cubit.dart';

@immutable
sealed class GetProductOptionsState {}

final class GetProductOptionsInitial extends GetProductOptionsState {}

final class GetProductOptionsSuccess extends GetProductOptionsState {
  final List<ProductOptionEntity> options;

  GetProductOptionsSuccess({required this.options});
}

final class GetProductOptionsFailure extends GetProductOptionsState {
  final String errMessage;

  GetProductOptionsFailure({required this.errMessage});
}

final class GetProductOptionsLoading extends GetProductOptionsState {}
