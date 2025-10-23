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
    required String address,
    required String visa,
  }) async {
    emit(EditProfileLoading());
    final result = await authRepo.updateProfileData(
      name,
      imagePath,
      address,
      visa,
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
