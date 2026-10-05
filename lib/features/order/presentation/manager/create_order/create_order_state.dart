part of 'create_order_cubit.dart';

@immutable
sealed class CreateOrderState {}

final class CreateOrderInitial extends CreateOrderState {}

final class CreateOrderSuccess extends CreateOrderState {
  final int orderId;

  CreateOrderSuccess({required this.orderId});
}

final class CreateOrderFailure extends CreateOrderState {
  final String errMessage;

  CreateOrderFailure({required this.errMessage});
}

final class CreateOrderLoading extends CreateOrderState {}
