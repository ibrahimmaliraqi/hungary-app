import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/use_cases/create_order.dart';
import 'package:meta/meta.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  final CreateOrderUseCase createOrderUseCase;
  CreateOrderCubit({required this.createOrderUseCase})
    : super(CreateOrderInitial());
  Future createOrder({required OrderEntity order}) async {
    emit(CreateOrderLoading());
    final res = await createOrderUseCase.call(order: order);
    res.fold(
      (l) => emit(CreateOrderFailure(errMessage: l.message)),
      (r) => emit(CreateOrderSuccess(orderId: r)),
    );
  }
}
