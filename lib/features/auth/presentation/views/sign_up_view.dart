import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/assets.dart';
import 'package:hungry_app/core/shared/custom_text.dart';
import 'package:hungry_app/core/shared/custom_text_form_field.dart';
import 'package:hungry_app/core/shared/snack.dart';
import 'package:hungry_app/core/utils/app_router.dart';
import 'package:hungry_app/core/utils/pref_helpers.dart';
import 'package:hungry_app/features/auth/data/manager/register/register_cubit.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry_app/features/auth/presentation/widgets/custom_auth_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => RegisterCubit(AuthRepoImpl()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(120),
                  SvgPicture.asset(
                    Assets.appLogo,
                    color: AppColors.primary,
                  ),
                  Gap(6),
                  Center(
                    child: CustomText(
                      text: "Delicious food, delivered fast.",
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Gap(80),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: BlocListener<RegisterCubit, RegisterState>(
                          listener: (context, state) {
                            if (state is RegisterSuccess) {
                              PrefHelpers.saveToken(state.user.data!.token!);
                              GoRouter.of(context).push(AppRouter.login);
                            }
                            if (state is RegisterFailure) {
                              Snack.show(context, message: state.errMessage);
                            }
                          },
                          child: Column(
                            children: [
                              Gap(50),

                              CustomTextFormField(
                                controller: nameController,
                                text: "Name",
                                isPassword: false,
                              ),
                              Gap(20),
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
                              BlocBuilder<RegisterCubit, RegisterState>(
                                builder: (context, state) {
                                  if (state is RegisterLoading) {
                                    return Center(
                                      child: CupertinoActivityIndicator(
                                        color: Colors.white,
                                        radius: 19,
                                      ),
                                    );
                                  }
                                  return CustomAuthButton(
                                    text: "Sign Up",
                                    color: Colors.transparent,
                                    textColor: Colors.white,
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<RegisterCubit>(
                                          context,
                                        ).register(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                              Gap(20),
                              CustomAuthButton(
                                text: "I already have an account",
                                onTap: () =>
                                    GoRouter.of(context).push(AppRouter.login),
                              ),
                              Gap(100),
                            ],
                          ),
                        ),
                      ),
                    ),
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
