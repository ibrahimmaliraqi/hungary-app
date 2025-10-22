import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());
  AuthRepo authRepo;
  register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    final result = await authRepo.register(name, email, password);
    result.fold(
      (fail) {
        emit(RegisterFailure(fail.errMessage));
      },
      (user) {
        emit(RegisterSuccess(user));
      },
    );
  }
}
