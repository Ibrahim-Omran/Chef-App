
import 'package:chef_app/core/locale/app_locale.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/features/menu/data/models/meal_model.dart';
import 'package:chef_app/features/menu/presentation/cubit/menu_cubit/menu_cubit.dart';
import 'package:chef_app/features/menu/presentation/cubit/menu_cubit/menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/custom_alert_dialog.dart';
import '../../../../core/widget/custom_cached_network_image.dart';

class MenuItemComponent extends StatelessWidget {
  const MenuItemComponent({
    super.key, required this.mealModel,
  });
  final MealModel mealModel ;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // image
        SizedBox(
          height: 70.h,
          width: 70.w,
          child:  CustomCachedNetworkImage(
            imageUrl: mealModel.images[0],
            fit: BoxFit.fill,
          ),
        ),

        SizedBox(
          width: 16.w,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 180.w),
              child: Text(
                mealModel.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 180.w),
              child: Text(
                mealModel.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 180.w),
              child: Text(
                mealModel.price.toString()+AppStrings.le.tr(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Spacer(),
        BlocConsumer<MenuCubit,MenuState>(
          listener: (context,state){
            if(state is DeleteDishSuccessState){
              BlocProvider.of<MenuCubit>(context).getAllMeals();
            }
          },
          builder: (context,state) {
            final cubit = BlocProvider.of<MenuCubit>(context);
            return IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(
                        message: AppStrings.deleteMeal.tr(context),
                        onPressed: (){
                          cubit.deleteDish(mealModel.id);
                          Navigator.pop(context);
                        },
                      );
                    });
              },
              icon: const Icon(
                Icons.cancel,
                size: 40,
                color: AppColors.red,
              ),
            );
          }
        )
      ],
    );
  }
}
