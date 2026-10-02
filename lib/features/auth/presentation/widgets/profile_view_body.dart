import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/widgets/custom_button.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/features/auth/presentation/widgets/profile_text_field.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController visaCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/profile.png",
                    ),
                  ),
                ),
              ),
              const Gap(10),

              CustomButton(
                text: "Upload",
                width: 100,
                hight: 30,
                color: Colors.white,
                textColor: AppColors.primary,
                onTap: () {},
              ),
              const Gap(30),

              ProfileTextField(label: "Name", controller: name),
              const Gap(25),
              ProfileTextField(label: "Email", controller: email),
              const Gap(25),
              ProfileTextField(
                label: "Delivery address",
                controller: address,
              ),
              const Gap(10),
              const Divider(),
              const Gap(10),

              const Gap(10),

              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                tileColor: Colors.white,
                title: const CustomText(
                  text: "Debit card",
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                subtitle: CustomText(
                  text: "مدري",
                  fontSize: 13,
                ),
                leading: Image.asset(
                  "assets/payout/visa.png",
                  width: 50,
                ),
                trailing: const CustomText(
                  text: "Default",
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),

              const Gap(100),
            ],
          ),
        ),
      ),
    );
  }
}
