
import 'package:chef_app/core/locale/app_locale.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_strings.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key, required this.message, required this.onPressed,
  });

  final String message ;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // content
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(color: AppColors.black,fontSize: 25),
      ),

      // action
      actions: [
        // Cancel Text
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancel.tr(context),
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColors.black,fontSize: 20),
          ),
        ),

        // confirm
        TextButton(
          onPressed: onPressed,
          child: Text(
            AppStrings.ok.tr(context),
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColors.black,fontSize: 20),
          ),
        ),
      ],
    );
  }
}
