import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/core/service/local_notification_service.dart';
import 'package:hungry_app/core/service/server_locator.dart';
import 'package:hungry_app/core/utils/app_router.dart';
import 'package:hungry_app/features/home/presentation/manager/add_product_cubit.dart';
import 'package:hungry_app/features/order/domain/use_cases/check_payment_status_usecase.dart';
import 'package:hungry_app/features/order/domain/use_cases/create_order.dart';
import 'package:hungry_app/features/order/domain/use_cases/create_payment_usecase.dart';
import 'package:hungry_app/features/order/presentation/manager/check_payment_status/check_payment_status_cubit.dart';
import 'package:hungry_app/features/order/presentation/manager/create_order/create_order_cubit.dart';
import 'package:hungry_app/features/order/presentation/manager/create_payment/create_payment_cubit.dart';
import 'package:hungry_app/observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await LocalNotificationService.instance.initialize();
  await PrefsHelper.init();

  setupLocator();

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
          create: (context) => AddProductCubit(),
        ),
        BlocProvider(
          create: (context) => CreateOrderCubit(
            createOrderUseCase: getIt.get<CreateOrderUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => CreatePaymentCubit(
            createPaymentUsecase: getIt.get<CreatePaymentUsecase>(),
          ),
        ),
        BlocProvider(
          create: (context) => CheckPaymentStatusCubit(
            checkPaymentStatusUsecase: getIt.get<CheckPaymentStatusUsecase>(),
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
