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
import 'package:hungry_app/features/auth/data/manager/login/login_cubit.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:hungry_app/features/auth/presentation/widgets/custom_auth_button.dart';
import 'package:hungry_app/root_view.dart';

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
      child: BlocProvider(
        create: (context) => LoginCubit(AuthRepoImpl()),
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
                        child: Column(
                          children: [
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
                            BlocListener<LoginCubit, LoginState>(
                              listener: (context, state) {
                                if (state is LoginSuccess) {
                                  PrefHelpers.saveToken(
                                    state.user.data!.token!,
                                  );

                                  // الانتقال للـ RootView
                                  GoRouter.of(context).push(AppRouter.rootView);
                                } else if (state is LoginFailure) {
                                  Snack.show(
                                    context,
                                    message: state.errMessage,
                                  );
                                }
                              },
                              child: BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      if (state is LoginLoading)
                                        Center(
                                          child: CupertinoActivityIndicator(
                                            radius: 19,
                                            color: Colors.white,
                                          ),
                                        ),

                                      CustomAuthButton(
                                        text: "Sign In",
                                        textColor: Colors.white,
                                        color: Colors.transparent,
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<LoginCubit>(
                                              context,
                                            ).login(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            Gap(20),
                            CustomAuthButton(
                              text: "Create Account ",
                              onTap: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpView(),
                                ),
                                (route) => false,
                              ),
                            ),
                            Gap(20),
                            CustomAuthButton(
                              text: "Continue as a Guest",
                              textColor: Colors.white,
                              color: Colors.transparent,
                              onTap: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RootView(),
                                ),
                                (route) => false,
                              ),
                            ),
                            Gap(100),
                          ],
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
