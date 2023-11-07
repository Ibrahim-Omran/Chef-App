import 'package:chef_app/core/database/api/api_consumer.dart';
import 'package:chef_app/core/database/api/end_points.dart';
import 'package:chef_app/core/database/cache/cache_helper.dart';
import 'package:chef_app/features/menu/data/models/meal_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utils/commons.dart';

class MenuRepository {
  Future<Either<String, String>> addDishToMenu({
    required XFile image,
    required String mealName,
    required String mealDisc,
    required String mealCategory,
    required String howToSell,
    required double mealPrice,
  }) async {
    try {
      final response = await sl<ApiConsumer>().post(
        EndPoint.addMeal,
        isFormData:true,
        data: {
          ApiKeys.name: mealName,
          ApiKeys.price: mealPrice,
          ApiKeys.description: mealDisc,
          ApiKeys.category: mealCategory,
          ApiKeys.howToSell: howToSell,
          ApiKeys.mealImages: await uploadImageToApi(image),
        },
      );
      return Right(response[ApiKeys.message]);
    } on ServerException catch (error) {
      return left(error.errorModel.errorMessage);
    }
  }


  // delete ..
  Future<Either<String, String>> deleteMeal({
    required String id,
  }) async {
    try {
      final response = await sl<ApiConsumer>().delete(
        EndPoint.getDeleteMealEndPoint(id),
      );
      return Right(response[ApiKeys.message]);
    } on ServerException catch (error) {
      return left(error.errorModel.errorMessage);
    }
  }


  //get meal
  Future<Either<String, GetAllMealsModel>> getMeals() async {
    try {
      final response = await sl<ApiConsumer>().get(
        EndPoint.getAllChefsMeals(sl<CacheHelper>().getData(key: ApiKeys.id)),
      );
      return Right(GetAllMealsModel.fromJson(response));
    } on ServerException catch (error) {
      return left(error.errorModel.errorMessage);
    }
  }
}
