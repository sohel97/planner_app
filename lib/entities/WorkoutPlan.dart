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
  String planner = "planner";
  String planName = "";
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
  String key = "";
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

  WorkoutPlan.getFromJson(var json, String key) {
    this.key = key;
    planner = "planner"; //json["planner"];
    planName = json["planName"];
    planDescription = json["planDescription"];
    dayOne = WorkoutDay.getFromJson(json["day1"]);
    dayTwo = WorkoutDay.getFromJson(json["day2"]);
    dayThree = WorkoutDay.getFromJson(json["day3"]);
    dayFour = WorkoutDay.getFromJson(json["day4"]);
    dayFive = WorkoutDay.getFromJson(json["day5"]);
    daySix = WorkoutDay.getFromJson(json["day6"]);
    daySeven = WorkoutDay.getFromJson(json["day7"]);
    startDate = DateTime.parse(json["startDate"]);
    endDate = DateTime.parse(json["endDate"]);
  }
  String getKey() {
    if (key != "") return key;
    key = endDate.year.toString() +
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
      "planName": planName == null ? "untitled" : planName,
      "planDescription": planDescription,
      "planner": planner,
      "startDate": startDate.toString(),
      "endDate": endDate.toString(),
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
