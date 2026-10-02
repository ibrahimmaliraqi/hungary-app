import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/core/utils/app_router.dart';
import 'package:hungry_app/features/auth/presentation/widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: Colors.white,
          elevation: 0,

          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.settings, color: Colors.black),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        body: ProfileViewBody(),
        // زر التعديل وتسجيل الخروج
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 70,
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      const CustomText(
                        text: "Edit Profile",
                        color: AppColors.primary,
                      ),
                      const Gap(10),
                      SvgPicture.asset(
                        "assets/logo/edit.svg",
                        height: 20,
                        width: 20,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () =>
                    GoRouter.of(context).pushReplacement(AppRouter.login),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 23,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: const [
                      CustomText(
                        text: "Log out",
                        color: Colors.white,
                      ),
                      Gap(10),
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
