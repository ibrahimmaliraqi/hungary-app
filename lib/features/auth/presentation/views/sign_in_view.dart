import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/assets.dart';
import 'package:hungry_app/core/shared/custom_text.dart';
import 'package:hungry_app/core/shared/custom_text_form_field.dart';
import 'package:hungry_app/features/auth/presentation/widgets/custom_auth_button.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Gap(50),
                  SvgPicture.asset(Assets.appLogo),
                  Gap(6),
                  Center(
                    child: CustomText(
                      text: "Delicious food, delivered fast.",
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Gap(50),
                  CustomTextFormField(
                    controller: emailController,
                    text: "Email Address",
                    isPassword: false,
                  ),
                  Gap(20),
                  CustomTextFormField(
                    controller: passwordController,
                    text: "Password",
                    isPassword: true,
                  ),
                  Gap(30),
                  CustomAuthButton(
                    text: "Sign In",
                    onTap: () {
                      if (formKey.currentState!.validate()) {}
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
