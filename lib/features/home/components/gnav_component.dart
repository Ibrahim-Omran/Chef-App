import 'package:chef_app/core/locale/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../presentation/cubit/home_cubit/home_cubit.dart';

class GNavComponent extends StatelessWidget {
  const GNavComponent({
    super.key,
    required this.cubit,
  });

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GNav(
      activeColor: AppColors.primary,
      selectedIndex: cubit.currentIndex,
      onTabChange: (value) {
        cubit.changeIndex(value);
      },
      tabBackgroundColor: AppColors.black12,
      tabBorderRadius: 16,
      padding: const EdgeInsets.all(16),
      gap: 8.w,
      tabs: [
        const GButton(
          icon: Icons.menu,
          text: 'menu',
        ),
        GButton(
          icon: Icons.person,
          text: AppStrings.editProfile.tr(context),
        ),
      ],
    );
  }
}
