import 'package:flutter/cupertino.dart';
import 'package:planner_app/entities/Workout.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     WorkoutPlan.dart
|
|  Purpose:  Workout Plan Class
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */

class WorkoutMuscleItem {
  bool isExpanded;
  String header;
  List<Workout> workouts;
  String iconpic;
  WorkoutType type;
  WorkoutMuscleItem(
      {@required this.header, @required this.iconpic, @required this.type}) {
    this.isExpanded = false;
    this.workouts = new List<Workout>();
  }
}
