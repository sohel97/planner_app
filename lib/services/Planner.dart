import 'package:flutter/cupertino.dart';
import 'package:planner_app/entities/Workout/WorkoutPlan.dart';

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

class Planner {
  String firstName;
  String lastName;
  String id;
  List<WorkoutPlan> plans = new List<WorkoutPlan>();
  Planner(
      {@required this.firstName,
      @required this.lastName,
      @required this.plans,
      @required this.id});

  String getFullname() {
    return "${this.firstName} ${this.lastName}";
  }

  addNewPlan(WorkoutPlan newPlan) {
    plans.add(newPlan);
  }

  getJson() {
    var json = {};
    json["firstName"] = this.firstName;
    json["lastName"] = this.lastName;
    var plansHistory = {};
    for (WorkoutPlan plan in this.plans) {
      plansHistory[plan.getKey()] = plan.getJson();
    }
    json["plans"] = plansHistory;
    return json;
  }

  getPlansHistoryJson() {
    var plansHistory = {};
    for (WorkoutPlan plan in this.plans) {
      plansHistory[plan.getKey()] = plan.getJson();
    }
    return plansHistory;
  }

  Planner.fromPlanner(var json) {
    this.firstName = json["firstName"];
    this.lastName = json["lastName"];
    this.id = json["idNumber"];
    var plansHistory = json["PremadePlans"];
    Map<String, dynamic> mapOfMaps = Map.from(plansHistory);
    mapOfMaps.entries.forEach((entry) {
      this
          .plans
          .add(new WorkoutPlan.getFromJson(Map.from(entry.value), entry.key));
    });
    this.plans.sort((a, b) => a.endDate.compareTo(b.endDate));
  }
}
