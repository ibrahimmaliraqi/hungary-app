part of 'toppings_cubit.dart';

@immutable
sealed class ToppingsState {}

final class ToppingsInitial extends ToppingsState {}

final class ToppingsLoading extends ToppingsState {}

final class ToppingsFailure extends ToppingsState {
  final String errMessage;

  ToppingsFailure(this.errMessage);
}

final class ToppingsSuccess extends ToppingsState {
  final List<ToppingsModel> toppings;

  ToppingsSuccess(this.toppings);
}
