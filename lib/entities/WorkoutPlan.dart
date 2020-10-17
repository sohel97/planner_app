import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:planner_app/services/Calculations.dart';

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
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool currentPlan = false;
  String key = "";
  WorkoutPlan({this.planName}) {
    dayOne = new WorkoutDay();
    dayTwo = new WorkoutDay();
    dayThree = new WorkoutDay();
    dayFour = new WorkoutDay();
    dayFive = new WorkoutDay();
    daySix = new WorkoutDay();
    daySeven = new WorkoutDay();
    startDate = DateTime.now();
    endDate = startDate;
    endDate = startDate.add(new Duration(days: 10));
    currentPlan = false;
  }

  WorkoutPlan clone() {
    WorkoutPlan newPlan = new WorkoutPlan();
    newPlan.planName = this.planName;
    newPlan.planDescription = this.planDescription;
    newPlan.planner = this.planner;
    newPlan.key = generateNewKey();
    newPlan.dayOne = this.dayOne.clone();
    newPlan.dayTwo = this.dayTwo.clone();
    newPlan.dayThree = this.dayThree.clone();
    newPlan.dayFour = this.dayFour.clone();
    newPlan.dayFive = this.dayFive.clone();
    newPlan.daySix = this.daySix.clone();
    newPlan.daySeven = this.daySeven.clone();
    newPlan.startDate = this.startDate;
    newPlan.endDate = this.endDate;
    newPlan.currentPlan = false;
    return newPlan;
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
    currentPlan = json["currentPlan"];
  }

  String generateNewKey() {
    return endDate.year.toString() +
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
  }

  String getKey() {
    if (key != "") return key;
    key = generateNewKey();
    return key;
  }

  Map<String, dynamic> getJson() {
    return {
      "planName": planName == null ? "untitled" : planName,
      "planDescription": planDescription,
      "planner": planner,
      "startDate": startDate.toString(),
      "endDate": endDate.toString(),
      "currentPlan": currentPlan,
      "day1": dayOne.getJson(),
      "day2": dayTwo.getJson(),
      "day3": dayThree.getJson(),
      "day4": dayFour.getJson(),
      "day5": dayFive.getJson(),
      "day6": daySix.getJson(),
      "day7": daySeven.getJson()
    };
  }

  String getNameAndPeriod() {
    return planName +
        "\nStart: " +
        convertDate(startDate) +
        ", End: " +
        convertDate(endDate);
  }

  bool checkIfOverlap(WorkoutPlan plan) {
    return plan.startDate.isBefore(endDate) && startDate.isBefore(plan.endDate);
  }

  setEndDate(int duration) {
    endDate = startDate.add(new Duration(days: duration));
  }
}
