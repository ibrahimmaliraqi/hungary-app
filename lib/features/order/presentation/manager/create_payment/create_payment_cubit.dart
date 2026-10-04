import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/entities/payment_entity.dart';
import 'package:hungry_app/features/order/domain/use_cases/create_payment_usecase.dart';
import 'package:meta/meta.dart';

part 'create_payment_state.dart';

class CreatePaymentCubit extends Cubit<CreatePaymentState> {
  final CreatePaymentUsecase createPaymentUsecase;
  CreatePaymentCubit({required this.createPaymentUsecase})
    : super(CreatePaymentInitial());
  Future createPayment({
    required PaymentEntity payment,
    required OrderEntity order,
  }) async {
    emit(CreatePaymentLoading());
    final res = await createPaymentUsecase.call(payment: payment, order: order);
    res.fold(
      (l) => emit(CreatePaymentFailure(errMessage: l.message)),
      (r) => emit(CreatePaymentSuccess(paymentUrl: r)),
    );
  }
}
