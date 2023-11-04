import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.validator,
    this.obscureText = false,
    this.iconSuffix,
    this.suffixIconOnPressed,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? iconSuffix;
  final VoidCallback? suffixIconOnPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.primary,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        hintText: hintText,
        labelText: labelText,
        suffixIcon: IconButton(
          onPressed: suffixIconOnPressed,
          icon: Icon(
            iconSuffix,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
