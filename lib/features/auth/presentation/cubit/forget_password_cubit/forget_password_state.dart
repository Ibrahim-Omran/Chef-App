abstract class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState{}

// Send code ..
final class SendCodeLoadingState extends ForgetPasswordState{}
final class SendCodeSuccessState extends ForgetPasswordState{
  final String message;
  SendCodeSuccessState(this.message);
}
final class SendCodeErrorState extends ForgetPasswordState{
  final String message;
  SendCodeErrorState(this.message);
}

// Change Suffix Icon
class ChangeNewPasswordSuffixIcon extends ForgetPasswordState{}
class ChangeConfirmPasswordSuffixIcon extends ForgetPasswordState{}

// Reset Password ..
final class ResetPasswordLoadingState extends ForgetPasswordState{}
final class ResetPasswordSuccessState extends ForgetPasswordState{
  final String message;
  ResetPasswordSuccessState(this.message);
}
final class ResetPasswordErrorState extends ForgetPasswordState{
  final String message;
  ResetPasswordErrorState(this.message);
}