import 'package:flutter/cupertino.dart';
import 'package:planner_app/entities/Workout.dart';

import 'Workout.dart';

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

  WorkoutMuscleItem.getFromJson(var json) {
    isExpanded = json["isExpanded"];
    header = json["header"];
    var workouts = json["workouts"];
    Map<String, dynamic> mapOfMaps = Map.from(workouts);
    mapOfMaps.values.forEach((value) {
      this.workouts.add(new Workout.getFromJson(Map.from(value)));
    });
    iconpic = json["iconpic"];
    type = stringToType[json["type"]];
  }

  getJson() {
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
