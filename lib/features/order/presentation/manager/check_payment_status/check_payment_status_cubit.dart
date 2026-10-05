import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/order/domain/use_cases/check_payment_status_usecase.dart';
import 'package:meta/meta.dart';

part 'check_payment_status_state.dart';

class CheckPaymentStatusCubit extends Cubit<CheckPaymentStatusState> {
  final CheckPaymentStatusUsecase checkPaymentStatusUsecase;

  Timer? _timer;

  CheckPaymentStatusCubit({
    required this.checkPaymentStatusUsecase,
  }) : super(CheckPaymentStatusInitial());

  Future<void> checkPaymentStatus({
    required String orderId,
  }) async {
    // إلغاء أي polling سابق
    _timer?.cancel();

    // أول فحص مباشرة
    await _checkPayment(orderId);

    // إذا ما صار Paid، ابدأ الفحص كل ثانيتين
    if (state is! CheckPaymentStatusPaid ||
        !(state as CheckPaymentStatusPaid).isPaid) {
      _timer = Timer.periodic(
        const Duration(seconds: 2),
        (_) async {
          await _checkPayment(orderId);
        },
      );
    }
  }

  Future<void> _checkPayment(String orderId) async {
    final res = await checkPaymentStatusUsecase.call(
      orderId: orderId,
    );

    res.fold(
      (l) {
        emit(
          CheckPaymentStatusFailure(
            errMessage: l.message,
          ),
        );
      },
      (isPaid) {
        emit(
          CheckPaymentStatusPaid(
            isPaid: isPaid,
          ),
        );

        // إذا صار الدفع ناجح، نوقف الطلبات
        if (isPaid) {
          _timer?.cancel();
          _timer = null;
        }
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
