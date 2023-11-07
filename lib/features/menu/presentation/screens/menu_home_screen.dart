import 'package:chef_app/core/locale/app_locale.dart';
import 'package:chef_app/core/utils/commons.dart';
import 'package:chef_app/core/widget/custom_loading_indecator.dart';
import 'package:chef_app/features/menu/presentation/cubit/menu_cubit/menu_cubit.dart';
import 'package:chef_app/features/menu/presentation/cubit/menu_cubit/menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widget/custom_button.dart';
import '../components/menu_item_component.dart';

class MenuHomeScreen extends StatelessWidget {
  const MenuHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Add dish to menu button
              CustomButton(
                onPressed: () {
                  navigate(context: context, route: Routes.addMeal);
                },
                text: AppStrings.addDishToMenu.tr(context),
              ),

              // items
              BlocBuilder<MenuCubit, MenuState>(builder: (context, state) {
                final cubit = BlocProvider.of<MenuCubit>(context);
                return Expanded(
                        child: state is GetAllChefMealsLoadingState
                            ? const CustomLoadingIndicator()
                            : cubit.meals.isEmpty
                            ?   Center(child: Text(AppStrings.noMeals.tr(context)))
                            : ListView.builder(
                                itemCount: cubit.meals.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 8),
                                    child: MenuItemComponent(
                                      mealModel: cubit.meals[index],
                                    ),
                                  );
                                },
                              ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
