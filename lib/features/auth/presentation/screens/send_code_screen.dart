import 'package:chef_app/core/locale/app_locale.dart';
import 'package:chef_app/core/utils/app_assets.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/widget/custom_image.dart';
import 'package:chef_app/core/widget/custom_text_form_field.dart';
import 'package:chef_app/features/auth/presentation/cubit/forget_password_cubit/forget_password_cubit.dart';
import 'package:chef_app/features/auth/presentation/cubit/forget_password_cubit/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/commons.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_loading_indecator.dart';

class SendCodeScreen extends StatelessWidget {
  const SendCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            navigateReplacement(
              context: context,
              route: Routes.login,
            );
          },
          icon: const Icon(
            Icons.arrow_back
          ),
        ),
        title: Text(
          AppStrings.forgetPassword.tr(context),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
            if (state is SendCodeSuccessState) {
              // 1. show message
              showToast(
                message: state.message,
                state: ToastState.success,
              );

              // 2. navigate to forget change password screen
              navigateReplacement(
                context: context,
                route: Routes.resetPassword,
              );
            }
            if (state is SendCodeErrorState) {
              showToast(
                message: state.message,
                state: ToastState.error,
              );
            }
          }, builder: (context, state) {
            final cubit = BlocProvider.of<ForgetPasswordCubit>(context);
            return Form(
              key: cubit.sendCodeKey,
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
                    AppStrings.sendResetLinkInfo.tr(context),
                  ),

                  SizedBox(
                    height: 26.h,
                  ),

                  //text field
                  CustomTextFormField(
                    controller: cubit.emailController,
                    hintText: AppStrings.email.tr(context),
                    validator: (data) {
                      if (data!.isEmpty || !data.contains('@gmail.com')) {
                        return AppStrings.pleaseEnterValidEmail.tr(context);
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 26.h,
                  ),

                  //button
                  state is SendCodeLoadingState
                      ? const CustomLoadingIndicator()
                      : CustomButton(
                          onPressed: () {
                            if (cubit.sendCodeKey.currentState!.validate()) {
                              cubit.sendCode();
                            }
                          },
                          text: AppStrings.sendResetLink.tr(context),
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
