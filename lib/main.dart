import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/core/utils/app_router.dart';
import 'package:hungry_app/features/auth/data/data_source/auth_remote.dart';
import 'package:hungry_app/features/auth/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'package:hungry_app/features/auth/presentation/manager/get_profile/get_profile_data_cubit.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry_app/features/product/data/manager/cart/cart_cubit.dart';
import 'package:hungry_app/features/home/presentation/manager/side_option/side_options_cubit.dart';
import 'package:hungry_app/features/home/presentation/manager/toppings/toppings_cubit.dart';
import 'package:hungry_app/features/product/data/repos/product_detils_repo_impl.dart';
import 'package:hungry_app/observer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Supabase.initialize(
    url: 'https://bttsdojxvucpzaqczsga.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ0dHNkb2p4dnVjcHphcWN6c2dhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg2NTY3MzAsImV4cCI6MjA4NDIzMjczMH0.Q0GgaYgqqfq1Xvkgb63z450sIlsaDh0wPXZCZmtsLVA',
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
          create: (context) => GetProfileDataCubit(
            AuthRepoImpl(authRemote: getIt.get<AuthRemote>()),
          ),
        ),
        BlocProvider(
          create: (context) => EditProfileCubit(
            AuthRepoImpl(authRemote: getIt.get<AuthRemote>()),
          ),
        ),
        BlocProvider(
          create: (context) => ToppingsCubit(ProductDetilsRepoImpl()),
        ),
        BlocProvider(
          create: (context) => CartCubit(ProductDetilsRepoImpl()),
        ),
        BlocProvider(
          create: (context) => SideOptionsCubit(ProductDetilsRepoImpl()),
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
