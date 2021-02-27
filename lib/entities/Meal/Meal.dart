/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     SubMeal.dart
|
|  Purpose:  Meal Class
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  04-Nov-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */

import 'package:flutter/foundation.dart';
import 'package:planner_app/entities/Meal/SubMeal.dart';

enum MealType {
  Breakfast,
  Lunch,
  Dinner,
  Snack,
}

class Meal {
  List<SubMeal> subMealOptions;
  MealType mealType;

  Meal({
    @required this.subMealOptions,
    @required this.mealType,
  });
}
