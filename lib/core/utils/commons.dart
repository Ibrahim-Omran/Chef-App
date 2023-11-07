import 'dart:io';

import 'package:chef_app/core/utils/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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

// Pick Image ..
Future<XFile?> pickImage(ImageSource source)async{
  XFile? image = await ImagePicker().pickImage(source: source);
  if(image != null){
    return image ;
  }else{
    return null ;
  }
}

// عشان اقدر اخزن الصورة في api
Future uploadImageToApi(XFile image) async {
  return MultipartFile.fromFileSync(image.path,
      filename: image.path.split('/').last);

}