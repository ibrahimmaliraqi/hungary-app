import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  AuthRepo authRepo;
  login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await authRepo.login(email, password);
    result.fold(
      (fail) {
        emit(LoginFailure(fail.errMessage));
      },
      (user) {
        emit(LoginSuccess(user));
      },
    );
  }
}
