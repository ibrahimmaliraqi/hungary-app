import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/order/domain/use_cases/check_payment_status_usecase.dart';
import 'package:meta/meta.dart';

part 'check_payment_status_state.dart';

class CheckPaymentStatusCubit extends Cubit<CheckPaymentStatusState> {
  final CheckPaymentStatusUsecase checkPaymentStatusUsecase;
  CheckPaymentStatusCubit({required this.checkPaymentStatusUsecase})
    : super(CheckPaymentStatusInitial());
  Future checkPaymentStatus({required String orderId}) async {
    final res = await checkPaymentStatusUsecase.call(orderId: orderId);
    res.fold(
      (l) => emit(CheckPaymentStatusFailure(errMessage: l.message)),
      (r) => emit(CheckPaymentStatusPaid(isPaid: r)),
    );
  }
}
