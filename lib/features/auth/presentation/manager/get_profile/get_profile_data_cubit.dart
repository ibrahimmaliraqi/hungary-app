import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';
import 'package:hungry_app/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'get_profile_data_state.dart';

class GetProfileDataCubit extends Cubit<GetProfileDataState> {
  GetProfileDataCubit(this.authRepo) : super(GetProfileDataInitial());
  AuthRepo authRepo;
  getProfileData({required String uId}) async {
    emit(GetProfileDataLoading());
    final result = await authRepo.getProfileData(id: uId);
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
