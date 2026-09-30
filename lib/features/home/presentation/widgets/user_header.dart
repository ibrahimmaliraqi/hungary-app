import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/assets.dart';
import 'package:hungry_app/core/helper/prefs_helper.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/core/widgets/net_image.dart';
import 'package:hungry_app/features/home/presentation/views/wayl.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = PrefsHelper.getUser();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Assets.appLogo,
              height: 30,
              color: AppColors.primary,
            ),
            Gap(5),
            CustomText(
              text: "مرحباً، ${userData?.name ?? "قم بتسحيل الدخول"}",
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.blueGrey.shade500,
            ),
          ],
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300),
            border: Border.all(
              color: AppColors.primary,

              width: 3,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(300),

            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WaylPaymentPage(),
                  ),
                );
              },
              child: NetImage(
                imageUrl: userData!.image!,

                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
