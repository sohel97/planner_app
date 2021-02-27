import 'package:flutter/cupertino.dart';
import 'package:planner_app/entities/Workout/Workout.dart';

import '../Workout/Workout.dart';

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
  List<Workout> workouts = new List<Workout>();
  String iconpic;
  WorkoutType type;
  WorkoutMuscleItem(
      {@required this.header, @required this.iconpic, @required this.type}) {
    this.isExpanded = false;
    this.workouts = new List<Workout>();
  }
  WorkoutMuscleItem clone() {
    WorkoutMuscleItem newWorkoutMuscle = new WorkoutMuscleItem(
        header: this.header, iconpic: this.iconpic, type: this.type);
    for (Workout work in workouts) {
      newWorkoutMuscle.workouts.add(work.clone());
    }
    newWorkoutMuscle.isExpanded = this.isExpanded;
    return newWorkoutMuscle;
  }

  WorkoutMuscleItem.getFromJson(var json) {
    isExpanded = json["isExpanded"];
    header = json["header"];
    this.workouts = new List<Workout>();
    var workouts = json["workouts"];
    if (workouts != null) {
      workouts.forEach((value) {
        if (value != null) this.workouts.add(new Workout.getFromJson(value));
      });
    }

    iconpic = json["iconpic"];
    type = stringToType[json["type"]];
  }

  Map<String, dynamic> getJson() {
    var workoutsJsons = {};
    for (int i = 0; i < workouts.length; i++) {
      workoutsJsons[(i + 1).toString()] = workouts[i].getJson();
    }
    return {
      "type": type.toString(),
      "header": header,
      "iconpic": iconpic,
      "isExpanded": isExpanded,
      "workouts": workoutsJsons
    };
  }
}
