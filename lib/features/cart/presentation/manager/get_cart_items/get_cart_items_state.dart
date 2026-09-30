part of 'get_cart_items_cubit.dart';

@immutable
sealed class GetCartItemsState {}

final class GetCartItemsInitial extends GetCartItemsState {}

final class GetCartItemsLoading extends GetCartItemsState {}

final class GetCartItemsFailure extends GetCartItemsState {
  final String errMessage;

  GetCartItemsFailure({required this.errMessage});
}

final class GetCartItemsSuccess extends GetCartItemsState {
  final List<CartEntity> carts;

  GetCartItemsSuccess({required this.carts});
}
