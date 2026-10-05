part of 'create_payment_cubit.dart';

@immutable
sealed class CreatePaymentState {}

final class CreatePaymentInitial extends CreatePaymentState {}

final class CreatePaymentLoading extends CreatePaymentState {}

final class CreatePaymentSuccess extends CreatePaymentState {
  final String paymentLink;

  CreatePaymentSuccess({
    required this.paymentLink,
  });
}

final class CreatePaymentFailure extends CreatePaymentState {
  final String errMessage;

  CreatePaymentFailure({
    required this.errMessage,
  });
}
