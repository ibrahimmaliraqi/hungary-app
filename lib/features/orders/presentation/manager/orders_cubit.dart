import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit()
      : super(OrdersInitial());

  Future<void> getOrders() async {
    emit(OrdersLoading());

    try {
      emit(OrdersSuccess());
    } catch (e) {
      emit(
        OrdersFailure(
          message: e.toString(),
        ),
      );
    }
  }
}