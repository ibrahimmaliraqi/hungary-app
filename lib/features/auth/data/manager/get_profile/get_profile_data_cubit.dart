import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'get_profile_data_state.dart';

class GetProfileDataCubit extends Cubit<GetProfileDataState> {
  GetProfileDataCubit(this.authRepo) : super(GetProfileDataInitial());
  AuthRepo authRepo;
  getProfileData({required String uId}) async {
    emit(GetProfileDataLoading());
    final result = await authRepo.getProfileData(uId: uId);
    result.fold(
      (fail) {
        emit(GetProfileDataFailure(fail.message));
      },
      (user) {
        emit(GetProfileDataSuccess(user));
      },
    );
  }
}
