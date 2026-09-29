import 'package:get_it/get_it.dart';
import 'package:hungry_app/core/network/dio_client.dart';
import 'package:hungry_app/features/auth/data/data_source/auth_remote.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry_app/features/auth/domain/repo/auth_repo.dart';
import 'package:hungry_app/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:hungry_app/features/auth/domain/use_case/register_user_usecase.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  //Services
  getIt.registerSingleton<DioClient>(DioClient());

  getIt.registerSingleton<AuthRemote>(
    ApiAuthRemoteImpl(dioClient: getIt.get<DioClient>()),
  );

  //repo
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authRemote: getIt.get<AuthRemote>()),
  );

  //use case
  getIt.registerSingleton<RegisterUserUsecase>(
    RegisterUserUsecase(authRepo: getIt.get<AuthRepo>()),
  );
  getIt.registerSingleton<LoginUserUsecase>(
    LoginUserUsecase(authRepo: getIt.get<AuthRepo>()),
  );
}
