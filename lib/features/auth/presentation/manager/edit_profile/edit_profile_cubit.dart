import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';
import 'package:hungry_app/features/auth/domain/use_case/update_user_usecase.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateUserUsecase updateUserUsecase;
  EditProfileCubit({required this.updateUserUsecase})
    : super(EditProfileInitial());
  editProfileData({required UserEntity user}) async {
    emit(EditProfileLoading());
    final result = await updateUserUsecase.call(user: user);
    result.fold(
      (fail) {
        emit(EditProfileFailure(fail.message));
      },
      (user) {
        emit(EditProfileSuccess(user));
      },
    );
  }
}
