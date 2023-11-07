import 'package:chef_app/core/locale/app_locale.dart';
import 'package:chef_app/core/routes/app_routes.dart';
import 'package:chef_app/core/utils/app_assets.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commons.dart';
import 'package:chef_app/core/widget/custom_button.dart';
import 'package:chef_app/core/widget/custom_image.dart';
import 'package:chef_app/core/widget/custom_loading_indecator.dart';
import 'package:chef_app/core/widget/custom_text_form_field.dart';
import 'package:chef_app/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:chef_app/features/auth/presentation/cubit/login_cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //header that contains image and welcome back text
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const CustomImage(
                    imgPath: AppAssets.backgroundTwo,
                    width: double.infinity,
                  ),
                  Text(
                    AppStrings.welcomeBack.tr(context),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              SizedBox(
                height: 100.h,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      showToast(
                        message: AppStrings.loginSuccessfully.tr(context),
                        state: ToastState.success,
                      );
                      navigateReplacement(
                        context: context,
                        route: Routes.home,
                      );
                    }
                    if (state is LoginErrorState) {
                      showToast(
                        message: state.message,
                        state: ToastState.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    final cubit = BlocProvider.of<LoginCubit>(context);
                    return Form(
                      key: cubit.loginKey,
                      child: Column(
                        children: [
                          //email
                          CustomTextFormField(
                            controller: cubit.emailController,
                            hintText: AppStrings.email.tr(context),
                            validator: (data) {
                              if (data!.isEmpty ||
                                  !data.contains('@gmail.com')) {
                                return AppStrings.pleaseEnterValidEmail
                                    .tr(context);
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 32.h,
                          ),

                          //password
                          CustomTextFormField(
                            controller: cubit.passwordController,
                            hintText: AppStrings.password.tr(context),
                            obscureText: cubit.isLoginPasswordSowing,
                            iconSuffix: cubit.suffixIcon,
                            suffixIconOnPressed: () {
                              cubit.changeLoginPasswordSuffixIcon();
                            },
                            validator: (data) {
                              if (data!.length < 6 || data.isEmpty) {
                                return AppStrings.pleaseEnterValidPassword
                                    .tr(context);
                              }
                              return null;
                            },
                          ),

                          SizedBox(
                            height: 24.h,
                          ),

                          // forget password..
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  navigateReplacement(
                                      context: context, route: Routes.sendCode);
                                },
                                child: Text(
                                  AppStrings.forgetPassword.tr(context),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 32.h,
                          ),

                          // button login
                          state is LoginLoadingState
                              ? const CustomLoadingIndicator()
                              : CustomButton(
                                  onPressed: () {
                                    if (cubit.loginKey.currentState!
                                        .validate()) {
                                      cubit.login();
                                    }
                                  },
                                  text: AppStrings.signIn.tr(context),
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
