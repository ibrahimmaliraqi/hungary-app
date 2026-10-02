import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';
import 'package:hungry_app/features/auth/domain/use_case/get_user_profile_usecase.dart';
import 'package:meta/meta.dart';

part 'get_profile_data_state.dart';

class GetProfileDataCubit extends Cubit<GetProfileDataState> {
  final GetUserProfileUsecase getUserProfileUsecase;
  GetProfileDataCubit(this.getUserProfileUsecase)
    : super(GetProfileDataInitial());
  getProfileData({required String uId}) async {
    emit(GetProfileDataLoading());
    final result = await getUserProfileUsecase.call(id: uId);
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
