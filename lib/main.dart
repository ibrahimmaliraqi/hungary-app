import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/utils/app_router.dart';
import 'package:hungry_app/features/auth/data/manager/cubit/get_profile_data_cubit.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry_app/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Bloc.observer = MyBlocObserver();
  runApp(HungryApp());
}

class HungryApp extends StatelessWidget {
  const HungryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProfileDataCubit(AuthRepoImpl()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          splashColor: Colors.transparent,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
