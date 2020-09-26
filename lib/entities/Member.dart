import 'package:flutter/cupertino.dart';

import 'WorkoutPlan.dart';
import 'WorkoutPlan.dart';
import 'WorkoutPlan.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     Member.dart
|
|  Purpose: Member Class
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */

class Member {
  String firstName;
  String lastName;
  String id;
  List<WorkoutPlan> plansHistory;
  WorkoutPlan currentPlan;
  Member(
      {@required this.firstName,
      @required this.lastName,
      @required this.plansHistory,
      @required this.id});

  String getFullname() {
    return "${this.firstName} ${this.lastName}";
  }

  addNewPlan(WorkoutPlan newPlan) {
    plansHistory.add(newPlan);
  }

  getCurrentPlanJson() {
    return currentPlan.getJson();
  }

  getJson() {
    var json = {};
    json["firstName"] = this.firstName;
    json["lastName"] = this.lastName;
    var plansHistory = {};
    for (WorkoutPlan plan in this.plansHistory) {
      plansHistory[plan.getKey()] = plan.getJson();
    }
    json["plansHistory"] = plansHistory;
    return json;
  }

  getPlansHistoryJson() {
    var plansHistory = {};
    for (WorkoutPlan plan in this.plansHistory) {
      plansHistory[plan.getKey()] = plan.getJson();
    }
    return plansHistory;
  }

  Member.fromMember(var json) {
    this.firstName = json["firstName"];
    this.lastName = json["lastName"];
    var plansHistory = json["plansHistory"];
    Map<String, dynamic> mapOfMaps = Map.from(plansHistory);
    mapOfMaps.values.forEach((value) {
      this.plansHistory.add(new WorkoutPlan.getFromJson(Map.from(value)));
    });
    this.plansHistory.sort((a, b) => a.endDate.compareTo(b.endDate));
    currentPlan = plansHistory[0];
  }
}
