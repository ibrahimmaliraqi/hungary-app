import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/core/utils/app_router.dart';
import 'package:hungry_app/features/auth/data/data_source/auth_remote.dart';
import 'package:hungry_app/features/auth/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry_app/features/home/presentation/manager/add_product_cubit.dart';
import 'package:hungry_app/observer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await PrefsHelper.init();
  await Supabase.initialize(
    url: 'https://ihlcguvkkmghordsncsp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlobGNndXZra21naG9yZHNuY3NwIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MzAzNzEzNiwiZXhwIjoyMDc4NjEzMTM2fQ.aR7jGVFyGnO46ZdtXGdLu0PidsmUyZ51W4pL-nST-OM',
  );
  setupLocator();

  Bloc.observer = MyBlocObserver();

  runApp(HungryApp());
}

final supabase = Supabase.instance.client;

class HungryApp extends StatelessWidget {
  const HungryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddProductCubit(),
        ),

        BlocProvider(
          create: (context) => EditProfileCubit(
            AuthRepoImpl(authRemote: getIt.get<AuthRemote>()),
          ),
        ),
      ],
      child: MaterialApp.router(
        locale: Locale("ar"),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: [
          Locale('en'), // English
          Locale('ar'), // Spanish
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: Colors.white,
          splashColor: Colors.transparent,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
