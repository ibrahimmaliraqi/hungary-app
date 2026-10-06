import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/assets.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/core/router/app_router.dart';
import 'package:hungry_app/features/auth/domain/entities/user_entity.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 2),
      () {
        UserEntity? user = PrefsHelper.getUser();
        if (user == null) {
          GoRouter.of(context).push(AppRouter.login);
        } else {
          GoRouter.of(context).push(AppRouter.rootView);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Gap(170),
              SvgPicture.asset(Assets.appLogo),
              Spacer(),
              Image.asset(Assets.splashLogo),
            ],
          ),
        ),
      ),
    );
  }
}
