import 'package:chef_app/core/bloc/cubit/global_cubit.dart';
import 'package:chef_app/core/bloc/cubit/global_state.dart';
import 'package:chef_app/core/locale/app_locale.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/custom_button.dart';

class ProfileHomeScreen extends StatelessWidget {
  const ProfileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,),
        child: BlocBuilder<GlobalCubit,GlobalState>(
          builder: (context,state) {
            final cubit = BlocProvider.of<GlobalCubit>(context);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                 Text(
                  AppStrings.pleaseChooseYourLanguage.tr(context),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.black),
                ),

                SizedBox(height: 40.h,),
                Row(
                  children: [
                    CustomButton(
                      text: 'English',
                      background: AppColors.black,
                      width: 140,
                      onPressed: () {
                        cubit.changeLang('en');

                      },
                    ),
                    const Spacer(),
                    CustomButton(
                      text: 'العربية',
                      background: AppColors.black,
                      width: 140,
                      onPressed: () {
                        cubit.changeLang('ar');

                      },
                    ),
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
