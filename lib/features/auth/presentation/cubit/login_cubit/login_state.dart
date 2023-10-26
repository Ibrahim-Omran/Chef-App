abstract class LoginState{}

final class LoginInitial extends LoginState{}
final class LoginLoadingState extends LoginState{}
final class LoginSuccessState extends LoginState{}
final class LoginErrorState extends LoginState{
  final String message ;
  LoginErrorState(this.message);
}

class ChangeLoginPasswordSuffixIcon extends LoginState{}