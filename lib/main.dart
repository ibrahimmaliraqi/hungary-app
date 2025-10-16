import 'package:flutter/material.dart';
import 'package:hungry_app/splash_view.dart';

void main() {
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
