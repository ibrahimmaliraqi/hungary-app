part of 'check_payment_status_cubit.dart';

@immutable
sealed class CheckPaymentStatusState {}

final class CheckPaymentStatusInitial extends CheckPaymentStatusState {}

final class CheckPaymentStatusFailure extends CheckPaymentStatusState {
  final String errMessage;

  CheckPaymentStatusFailure({required this.errMessage});
}

final class CheckPaymentStatusPaid extends CheckPaymentStatusState {
  final bool isPaid;

  CheckPaymentStatusPaid({required this.isPaid});
}
