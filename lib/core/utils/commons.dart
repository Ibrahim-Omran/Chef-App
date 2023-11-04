import 'package:chef_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigate({
  required BuildContext context,
  required String route,
  dynamic arg,
}) {
  Navigator.pushNamed(
    context,
    route,
    arguments: arg,
  );
}

void navigateReplacement({
  required BuildContext context,
  required String route,
  dynamic arg,
}) {
  Navigator.pushReplacementNamed(
    context,
    route,
    arguments: arg,
  );
}

// Toast ..
void showToast({
  required String message,
  required ToastState state,
}){
  Fluttertoast.showToast(
      msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    textColor: Colors.white,
    fontSize: 16.0
  );
}

enum ToastState {error , success , warining}
Color getStata(ToastState state){
  switch(state){
    case ToastState.error:
      return AppColors.red;
    case ToastState.success:
      return AppColors.green;
    case ToastState.warining:
      return AppColors.primary;
  }
}
