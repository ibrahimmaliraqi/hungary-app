part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String uId;

  RegisterSuccess(this.uId);
}

final class RegisterFailure extends RegisterState {
  final String errMessage;

  RegisterFailure(this.errMessage);
}
