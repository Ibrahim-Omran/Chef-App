import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCircle(
      color: AppColors.primary,
    );
  }
}
