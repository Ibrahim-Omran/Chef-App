import 'package:chef_app/core/database/api/end_points.dart';
import 'package:chef_app/core/database/cache/cache_helper.dart';
import 'package:chef_app/features/auth/data/models/login_model.dart';
import 'package:chef_app/features/auth/data/repository/auth_repository.dart';
import 'package:chef_app/features/auth/presentation/cubit/login_cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/service/service_locator.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepository authRepo;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoginPasswordSowing = true;
  IconData suffixIcon = Icons.visibility;

  void changeLoginPasswordSuffixIcon() {
    isLoginPasswordSowing = !isLoginPasswordSowing;
    suffixIcon =
        isLoginPasswordSowing ? Icons.visibility : Icons.visibility_off;

    emit(ChangeLoginPasswordSuffixIcon());
  }

  //login method
  LoginModel? loginModel;

  void login() async {
    emit(LoginLoadingState());
    final result = await authRepo.login(
      email: emailController.text,
      password: passwordController.text,
    );
    result.fold(
      (l) => emit(LoginErrorState(l)),
      (r) async {
        loginModel = r;
        //Save Token
        await sl<CacheHelper>().saveData(
          key: ApiKeys.token,
          value: r.token,
        );
        emit(LoginSuccessState());
      },
    );
  }
}
