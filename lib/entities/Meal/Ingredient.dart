/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     Ingredient.dart
|
|  Purpose:  Ingredient Class
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  04-Nov-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */
import 'package:flutter/material.dart';

enum IngredientQuantityType {
  per100gr,
  per100ml,
  perItem,
  perCup,
  perBigSpoon,
  perTeaSpoon,
}

class Ingredient {
  String ingredientName;
  IngredientQuantityType ingredientQuantityType;
  double quantity;
  int caloriesInOneUnit;
  int caloriesInMeal;

  Ingredient({
    @required this.ingredientName,
    @required this.ingredientQuantityType,
    @required this.quantity,
    @required this.caloriesInOneUnit,
  }) {
    calcCaloriesInIngredient();
  }

  void calcCaloriesInIngredient() {
    double quantityPerMeal = 0;
    switch (ingredientQuantityType) {
      case IngredientQuantityType.per100gr:
      case IngredientQuantityType.per100ml:
        {
          quantityPerMeal = quantity / 100;
          caloriesInMeal =
              (caloriesInOneUnit.toDouble() * quantityPerMeal) as int;
        }
        break;
      case IngredientQuantityType.perItem:
      case IngredientQuantityType.perCup:
      case IngredientQuantityType.perBigSpoon:
      case IngredientQuantityType.perTeaSpoon:
        {
          caloriesInMeal = (caloriesInOneUnit.toDouble() * quantity) as int;
        }
        break;
      default:
        {
          caloriesInMeal = caloriesInOneUnit;
        }
        break;
    }
  }
}
