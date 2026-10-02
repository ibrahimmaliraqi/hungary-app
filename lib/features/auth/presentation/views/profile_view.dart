import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/features/auth/presentation/widgets/profile_bottom_sheet.dart';
import 'package:hungry_app/features/auth/presentation/widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<void> _onRefresh() async {
    // TODO: استدعاء GetProfileCubit هنا
    await Future.delayed(
      const Duration(milliseconds: 700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,

        title: const CustomText(
          text: "الملف الشخصي",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),

        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              end: 16,
            ),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // TODO: Settings
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFE9ECEF),
                    ),
                  ),
                  child: const Icon(
                    Icons.settings_outlined,
                    size: 21,
                    color: Color(0xFF292D32),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: Colors.white,
        strokeWidth: 2.5,
        onRefresh: _onRefresh,
        child: const ProfileViewBody(),
      ),

      bottomSheet: const ProfileBottomSheet(),
    );
  }
}
