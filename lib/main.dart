import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/observer.dart';
import 'package:hungry_app/splash_view.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: SplashView(),
    );
  }
}
