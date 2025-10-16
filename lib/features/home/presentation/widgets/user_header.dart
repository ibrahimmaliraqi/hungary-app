import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/assets.dart';
import 'package:hungry_app/core/shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
              text: "Hello, Ibrahim Mohammed",
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

            child: Image.asset(
              "assets/test/test.jpg",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
