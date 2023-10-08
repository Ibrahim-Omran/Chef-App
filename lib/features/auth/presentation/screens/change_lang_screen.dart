import 'package:chef_app/core/utils/app_assets.dart';
import 'package:chef_app/core/widget/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/custom_button.dart';

class ChangeLangScreen extends StatelessWidget {
  const ChangeLangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            //background image
            const CustomImage(
              imgPath: AppAssets.background,
              width: double.infinity,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(
                    height: 116.h,
                  ),
                  CustomImage(
                    imgPath: AppAssets.appLogo,
                    height: 120.h,
                    width: 120.w,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'Welcome to Chef App',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 54.h,
                  ),
                  Text(
                    'Please choose your language',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 120.h,
                  ),
                  Row(
                    children: [
                      CustomButton(
                        text:'English',
                        background: AppColors.black,
                        width: 140,
                        onPressed: (){},
                      ),
                      const Spacer(),
                      CustomButton(
                        text:'العربية',
                        background: AppColors.black,
                        width: 140,
                        onPressed: (){},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

