import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.authRepo) : super(EditProfileInitial());
  AuthRepo authRepo;
  editProfileData({
    required String name,
    required String imagePath,
    required String email,
    required String address,
    required String visa,
  }) async {
    emit(EditProfileLoading());
    final result = await authRepo.updateProfileData(
      visa: visa,
      imagePath: imagePath,
      email: email,
      address: address,
      name: name,
    );
    result.fold(
      (fail) {
        emit(EditProfileFailure(fail.errMessage));
      },
      (user) {
        emit(EditProfileSuccess(user!));
      },
    );
  }
}
