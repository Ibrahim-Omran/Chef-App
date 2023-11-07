import 'package:chef_app/core/locale/app_locale.dart';
import 'package:chef_app/core/utils/app_assets.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/widget/custom_file_image.dart';
import 'package:chef_app/core/widget/custom_image.dart';
import 'package:chef_app/core/widget/custom_loading_indecator.dart';
import 'package:chef_app/core/widget/custom_text_form_field.dart';
import 'package:chef_app/features/menu/presentation/cubit/menu_cubit/menu_cubit.dart';
import 'package:chef_app/features/menu/presentation/cubit/menu_cubit/menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/commons.dart';
import '../../../../core/widget/custom_button.dart';
import '../components/image_picker_dialog_component.dart';

class AddMealScreen extends StatelessWidget {
  const AddMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.addDishToMenu.tr(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Center(
              child:
              BlocConsumer<MenuCubit, MenuState>(listener: (context, state) {
                if (state is AddDishSuccessState) {
                  showToast(
                    message: AppStrings.mealAddedSuccessfully,
                    state: ToastState.success,
                  );
                  Navigator.pop(context);
                  BlocProvider.of<MenuCubit>(context).getAllMeals();
                }
              },
                builder: (context, state) {
                final cubit = BlocProvider.of<MenuCubit>(context);
                return Form(
                  key: cubit.addToMenuKey,
                  child: Column(
                    children: [

                      // add photo of meal
                      Stack(
                        children: [
                          //image
                          CustomFileImage(
                            image: cubit.image,
                          ),
                          //add icon button
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            bottom: -7,
                            end: 1,
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ImagePickerDialog(
                                      cameraOnTap: () {
                                        Navigator.pop(context);
                                        pickImage(ImageSource.camera)
                                            .then((value) => cubit.takeImage(value));
                                      },
                                      galleryOnTap: () {
                                        Navigator.pop(context);
                                        pickImage(ImageSource.gallery)
                                            .then((value) => cubit.takeImage(value));
                                      },
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(
                        height: 16.h,
                      ),


                      // name text field
                      CustomTextFormField(
                        controller: cubit.mealNameController,
                        hintText: AppStrings.mealName.tr(context),
                        validator: (data) {
                          if (data!.isEmpty) {
                            return AppStrings.pleaseEnterValidMealName
                                .tr(context);
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      // price text field
                      CustomTextFormField(
                        controller: cubit.mealPriceController,
                        hintText: AppStrings.mealPrice.tr(context),
                        validator: (data) {
                          if (data!.isEmpty) {
                            return AppStrings.pleaseEnterValidMealPrice
                                .tr(context);
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      // disc text field
                      CustomTextFormField(
                        controller: cubit.mealDiscController,
                        hintText: AppStrings.mealDesc.tr(context),
                        validator: (data) {
                          if (data!.isEmpty) {
                            return AppStrings.pleaseEnterValidMealDesc
                                .tr(context);
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      // category text field
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: Text(AppStrings.category.tr(context)),
                        value: cubit.selectedItem,
                        items: cubit.categoryList
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (data) {
                          cubit.changeItem(data);
                        },
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      // quantity or number
                      Row(
                        children: [
                          // quantity
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.primary,
                                value: 'quantity',
                                groupValue: cubit.groupVal,
                                onChanged: (val) {
                                  cubit.changeGroupVal(val);
                                },
                              ),
                              Text(AppStrings.mealQuantity.tr(context)),
                            ],
                          ),

                          const Spacer(),

                          //number
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.primary,
                                value: 'number',
                                groupValue: cubit.groupVal,
                                onChanged: (val) {
                                  cubit.changeGroupVal(val);
                                },
                              ),
                              Text(AppStrings.mealNumber.tr(context)),
                            ],
                          )
                        ],
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      // add to menu button
                      state is AddDishLoadingState ?
                      const CustomLoadingIndicator()
                      : CustomButton(
                        onPressed: () {
                          if (cubit.addToMenuKey.currentState!.validate()) {
                            cubit.addDishToMenu();

                          }
                        },
                        text: AppStrings.addToMenu.tr(context),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
