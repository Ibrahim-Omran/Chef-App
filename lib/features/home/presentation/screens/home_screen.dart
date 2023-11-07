import 'package:chef_app/core/locale/app_locale.dart';
import 'package:chef_app/core/widget/custom_gnav_bar.dart';
import 'package:chef_app/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:chef_app/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../../core/utils/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      final cubit = BlocProvider.of<HomeCubit>(context);
      return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: CustomGNavWidget(
            currentIndex: cubit.currentIndex,
            onChanged: (value) {
              cubit.changeIndex(value);
            },
            tabs: [
              GButton(
                icon: Icons.menu,
                text: AppStrings.menu.tr(context),
              ),
              GButton(
                icon: Icons.person,
                text: AppStrings.profile.tr(context),
              ),
            ],
          ));
    });
  }
}
