import 'dart:math';

import 'package:planner_app/services/calculations.dart';

import 'WorkoutDay.dart';

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
class WorkoutPlan {
  String planner;
  String planName;
  String planDescription = "";
  WorkoutDay dayOne;
  WorkoutDay dayTwo;
  WorkoutDay dayThree;
  WorkoutDay dayFour;
  WorkoutDay dayFive;
  WorkoutDay daySix;
  WorkoutDay daySeven;
  DateTime startDate;
  DateTime endDate = DateTime.now();
  WorkoutPlan({this.planName, int days = 30}) {
    dayOne = new WorkoutDay();
    dayTwo = new WorkoutDay();
    dayThree = new WorkoutDay();
    dayFour = new WorkoutDay();
    dayFive = new WorkoutDay();
    daySix = new WorkoutDay();
    daySeven = new WorkoutDay();
    startDate = DateTime.now();
    endDate = DateTime.now();
    endDate.add(new Duration(days: days));
  }

  WorkoutPlan.getFromJson(var json) {
    planner = json["planner"];
    planName = json["planName"];
    planDescription = json["planDescription"];
    dayOne = WorkoutDay.getFromJson(json["dayOne"]);
    dayTwo = WorkoutDay.getFromJson(json["dayTwo"]);
    dayThree = WorkoutDay.getFromJson(json["dayThree"]);
    dayFour = WorkoutDay.getFromJson(json["dayFour"]);
    dayFive = WorkoutDay.getFromJson(json["dayFive"]);
    daySix = WorkoutDay.getFromJson(json["daySix"]);
    daySeven = WorkoutDay.getFromJson(json["daySeven"]);
    startDate = DateTime.parse(json["startDate"]);
    endDate = DateTime.parse(json["endDate"]);
  }
  String getKey() {
    var key = endDate.year.toString() +
        "|" +
        endDate.month.toString() +
        "|" +
        endDate.day.toString() +
        "|" +
        endDate.hour.toString() +
        "|" +
        endDate.minute.toString() +
        "|" +
        endDate.second.toString() +
        "|RandomNum:" +
        (new Random()).nextInt(100).toString();
    return key;
  }

  getJson() {
    return {
      "planName": planName,
      "planDescription": planDescription,
      "planner": planner,
      "startDate": convertDate(startDate),
      "endDate": convertDate(endDate),
      "day1": dayOne.getJson(),
      "day2": dayTwo.getJson(),
      "day3": dayThree.getJson(),
      "day4": dayFour.getJson(),
      "day5": dayFive.getJson(),
      "day6": daySix.getJson(),
      "day7": daySeven.getJson()
    };
  }

  setEndDate(int duration) {
    //TODO
  }
}
