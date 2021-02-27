/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     SubMeal.dart
|
|  Purpose:  SubMeal Class
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  04-Nov-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */

import 'package:flutter/cupertino.dart';
import 'package:planner_app/entities/Meal/Ingredient.dart';

class SubMeal {
  String sectionName;
  List<Ingredient> ingredientOptions;

  SubMeal({@required this.sectionName, @required this.ingredientOptions});
}
