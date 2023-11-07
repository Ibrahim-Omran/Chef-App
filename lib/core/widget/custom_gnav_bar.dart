import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/utils/app_colors.dart';

class CustomGNavWidget extends StatelessWidget {
  const CustomGNavWidget({
    super.key,
    required this.currentIndex,
    this.onChanged,
    required this.tabs,
  });

  final int currentIndex;
  final Function(int)? onChanged;
  final List<GButton> tabs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h),
      child: GNav(
        activeColor: AppColors.primary,
        selectedIndex: currentIndex,
        onTabChange: onChanged,
        tabBackgroundColor: AppColors.black12,
        tabBorderRadius: 16,
        padding: const EdgeInsets.all(16),
        gap: 8.w,
        tabs: tabs,
      ),
    );
  }
}
