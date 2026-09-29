part of 'side_options_cubit.dart';

@immutable
sealed class SideOptionsState {}

final class SideOptionsInitial extends SideOptionsState {}

final class SideOptionsLoading extends SideOptionsState {}

final class SideOptionsSuccess extends SideOptionsState {
  final List<ToppingsModel> sideOption;

  SideOptionsSuccess(this.sideOption);
}

final class SideOptionsFailure extends SideOptionsState {
  final String errMessage;

  SideOptionsFailure(this.errMessage);
}
