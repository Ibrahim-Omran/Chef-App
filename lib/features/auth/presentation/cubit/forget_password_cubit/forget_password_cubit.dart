import 'package:chef_app/features/auth/presentation/cubit/forget_password_cubit/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/auth_repository.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.authRepo) : super(ForgetPasswordInitial());

  final AuthRepository authRepo;

  // key => Send code Screen
  GlobalKey<FormState> sendCodeKey = GlobalKey<FormState>();

  // key => reset password Screen
  GlobalKey<FormState> resetPasswordKey = GlobalKey<FormState>();
  //email
  TextEditingController emailController = TextEditingController();
  // Code
  TextEditingController codeController = TextEditingController();

  // reset password logic

  // New password ..
  TextEditingController newPasswordController = TextEditingController();
  bool isNewPasswordSowing = true;
  IconData suffixIconNewPassword = Icons.visibility;

  void changeNewPasswordSuffixIcon() {
    isNewPasswordSowing = !isNewPasswordSowing;
    suffixIconNewPassword =
        isNewPasswordSowing ? Icons.visibility : Icons.visibility_off;

    emit(ChangeNewPasswordSuffixIcon());
  }

  // changeConfirmPasswordSuffixIcon..
  TextEditingController confirmPasswordController = TextEditingController();
  bool isConfirmPasswordSowing = true;
  IconData suffixIconConfirmPassword = Icons.visibility;

  void changeConfirmPasswordSuffixIcon() {
    isConfirmPasswordSowing = !isConfirmPasswordSowing;
    suffixIconConfirmPassword =
        isConfirmPasswordSowing ? Icons.visibility : Icons.visibility_off;

    emit(ChangeConfirmPasswordSuffixIcon());
  }

  // send code ..
  void sendCode() async {
    emit(SendCodeLoadingState());
    final res = await authRepo.sendCode(email: emailController.text);
    res.fold(
      (l) => emit(SendCodeErrorState(l)),
      (r) => emit(SendCodeSuccessState(r)),
    );
  }

  // change password method that recives new password
  // and confirm password and code and email
  void resetPassword() async {
    emit(ResetPasswordLoadingState());
    final res = await authRepo.resetPassword(
      email: emailController.text,
      password: newPasswordController.text,
      confirmPassword: confirmPasswordController.text,
      code: codeController.text,
    );
    res.fold(
      (l) => emit(ResetPasswordErrorState(l)),
      (r) => emit(ResetPasswordSuccessState(r)),
    );
  }
}
