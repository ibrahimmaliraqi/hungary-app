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
        CircleAvatar(
          backgroundColor: AppColors.primary,
          radius: 30,
          child: Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ),
        // CircleAvatar(
        //   backgroundColor: AppColors.primary,
        //   radius: 30,
        //   child: ClipRRect(
        //     borderRadius: BorderRadiusGeometry.circular(30),
        //     child: Image.asset(
        //       "assets/test/self.jpg",
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
