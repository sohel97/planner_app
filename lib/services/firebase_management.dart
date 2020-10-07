import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:planner_app/components/Alert.dart';
import 'package:planner_app/entities/Member.dart';
import 'package:planner_app/entities/Workout.dart';
import 'package:planner_app/entities/WorkoutPlan.dart';

import 'Calculations.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     firebaseManagement.dart
|
|  Purpose:  firebase management.
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */
//TODO this
enum OrderBy { WillExpireSoon, Expired, Freezed }
final ref = FirebaseDatabase().reference().child("Planners");
List<WorkoutPlan> premadePlans = new List<WorkoutPlan>();
getPlanerMembers({OrderBy orderBy, int days, String text = ""}) {
  return ref.child("Customers").once().then((DataSnapshot snapshot) {
    List<Member> members = new List<Member>();

    if (snapshot.value != null) {
      Map<String, dynamic> mapOfMaps = Map.from(snapshot.value);

      mapOfMaps.values.forEach((value) {
        print(Map.from(value));
        members.add(Member.fromMember(Map.from(value)));
      });
    }

    print("the length:${members.length}");
    return members;
  });
  /*
  List<WorkoutPlan> plans = new List<WorkoutPlan>();
  List<Member> members = new List<Member>();
  members.add(Member(
    firstName: 'sohel',
    lastName: 'kanaan',
    plansHistory: plans,
    id: '318303898',
  ));
  members.add(Member(
    firstName: 'ameer',
    lastName: 'ganeem',
    plansHistory: plans,
    id: '315825814',
  ));
  members.add(Member(
    firstName: 'yousef',
    lastName: 'khatib',
    plansHistory: plans,
    id: '207515825',
  ));

  return members;
   */
}

Future<MapEntry<String, dynamic>> checkPhoneNumber(
    String phoneNumber, BuildContext context) async {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  return ref
      .orderByChild("phoneNumber")
      .equalTo(phoneNumber)
      .once()
      .then((DataSnapshot snapshot) {
    if (snapshot.value != null) {
      Map<String, dynamic> mapOfMaps = Map.from(snapshot.value);
      //print("found!");
      return mapOfMaps.entries.toList()[0];
    }
    //showAlertDialog(context, "User Not Found!");
    return null;
  });
}

addPlanToCustomer(WorkoutPlan plan, Member member) {
  member.addNewPlan(plan);
  ref
      .child("Customers")
      .child(member.id)
      .child("plansHistory")
      .update(member.getPlansHistoryJson());
}

//TODO this
getAllPremadePlans() {
  /*
  premadePlans.add(new WorkoutPlan(planName: 'برنامج مبتدئين'));
  premadePlans.add(new WorkoutPlan(planName: 'برنامج للنزول بالوزن'));
  premadePlans.add(new WorkoutPlan(planName: 'برنامج متقدمين'));
   */
  ref.child("premadePlans").set(getJsonOfArr(premadePlans));
  return premadePlans;
}

Member getMemberInfoFromFirebase() {
  Member member = new Member();
  member.firstName = "sohel";
  member.lastName = "kanaan";

  return member;
}

//TODO this
List<Workout> getAllWorkouts(WorkoutType muscleName) {
  Workout workout1 = new Workout();
  workout1.gifPath = 'assets/images/workout.gif';
  workout1.workoutName = 'first';
  workout1.content = 'content';
  workout1.sideNote = 'sidenote';
  workout1.type = WorkoutType.Shoulders;

  Workout workout = new Workout();
  workout.gifPath = 'assets/images/workout.gif';
  workout.workoutName = 'name';
  workout.content = 'content';
  workout.sideNote = 'sidenote';
  workout.type = WorkoutType.Stretching;

  Workout workout2 = new Workout();
  workout2.gifPath = 'assets/images/workout.gif';
  workout2.workoutName = 'name';
  workout2.content = 'content';
  workout2.sideNote = 'sidenote';
  workout2.type = WorkoutType.Aerobic;

  List<Workout> list = new List<Workout>();
  list.add(workout);
  list.add(workout1);
  list.add(workout2);
  return list;
}

//TODO
addAsAPremadePlan(WorkoutPlan plan) {
  premadePlans.add(plan);

  ref.child("305180309").child("premadePlans").update(plan.getJson());
}

void updatePremadePlan(WorkoutPlan plan) {}
