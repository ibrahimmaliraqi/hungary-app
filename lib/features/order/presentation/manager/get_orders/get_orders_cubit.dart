import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/order/domain/entities/order_entity.dart';
import 'package:hungry_app/features/order/domain/use_cases/get_orders_usecase.dart';
import 'package:meta/meta.dart';

part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  final GetOrdersUsecase getOrdersUsecase;
  GetOrdersCubit({required this.getOrdersUsecase}) : super(GetOrdersInitial());
  Future getOrders({required int userId}) async {
    emit(GetOrdersLoading());
    final res = await getOrdersUsecase.call(userId: userId);
    res.fold(
      (l) => emit(GetOrdersFailure(errMessage: l.message)),
      (r) => emit(GetOrdersSuccess(orders: r)),
    );
  }
}
