import 'package:chef_app/core/locale/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/commons.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_image.dart';
import '../../../../core/widget/custom_loading_indecator.dart';
import '../../../../core/widget/custom_text_form_field.dart';
import '../cubit/forget_password_cubit/forget_password_cubit.dart';
import '../cubit/forget_password_cubit/forget_password_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            navigateReplacement(
              context: context,
              route: Routes.sendCode,
            );
          },
          icon: const Icon(
              Icons.arrow_back
          ),
        ),
        title: Text(
          AppStrings.createYourNewPassword.tr(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              // 1. show message
              showToast(
                message: state.message,
                state: ToastState.success,
              );

              // 2. navigate to forget change login screen
              navigateReplacement(
                context: context,
                route: Routes.login,
              );
            }
            if (state is ResetPasswordErrorState) {
              showToast(
                message: state.message,
                state: ToastState.error,
              );
            }

          }, builder: (context, state) {
            final cubit = BlocProvider.of<ForgetPasswordCubit>(context);
            return Form(
              key: cubit.resetPasswordKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),

                  //image
                  const CustomImage(
                    imgPath: AppAssets.lock,
                  ),

                  SizedBox(
                    height: 24.h,
                  ),

                  //text
                  Text(
                    AppStrings.createYourNewPassword.tr(context),
                  ),

                  SizedBox(
                    height: 26.h,
                  ),

                  // text field => New Password
                  CustomTextFormField(
                    controller: cubit.newPasswordController,
                    hintText: AppStrings.newPassword.tr(context),
                    obscureText: cubit.isNewPasswordSowing,
                    iconSuffix: cubit.suffixIconNewPassword,
                    suffixIconOnPressed: () {
                      cubit.changeNewPasswordSuffixIcon();
                    },
                    validator: (data) {
                      if (data!.length < 6 || data.isEmpty) {
                        return AppStrings.pleaseEnterValidPassword.tr(context);
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 26.h,
                  ),

                  // text field => Confirm Password
                  CustomTextFormField(
                    controller: cubit.confirmPasswordController,
                    hintText: AppStrings.confirmPassword.tr(context),
                    obscureText: cubit.isConfirmPasswordSowing,
                    iconSuffix: cubit.suffixIconConfirmPassword,
                    suffixIconOnPressed: () {
                      cubit.changeConfirmPasswordSuffixIcon();
                    },
                    validator: (data) {
                      if (data!.length < 6 || data.isEmpty) {
                        return AppStrings.pleaseEnterValidPassword.tr(context);
                      }
                      if (data != cubit.newPasswordController.text) {
                        return AppStrings.pleaseEnterValidPassword.tr(context);
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 26.h,
                  ),

                  // text field => Send Code
                  CustomTextFormField(
                    controller: cubit.codeController,
                    hintText: AppStrings.code.tr(context),
                    validator: (data) {
                      if (num.tryParse(data!) == null) {
                        return AppStrings.pleaseEnterValidCode.tr(context);
                      }
                      if (data.isEmpty) {
                        return AppStrings.pleaseEnterValidCode.tr(context);
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 26.h,
                  ),

                  //Button Send Code
                  state is ResetPasswordLoadingState
                      ? const CustomLoadingIndicator()
                      : CustomButton(
                          onPressed: () {
                            if (cubit.resetPasswordKey.currentState!
                                .validate()) {
                              cubit.resetPassword();
                            }
                          },
                          text: AppStrings.createYourNewPassword.tr(context),
                        ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
