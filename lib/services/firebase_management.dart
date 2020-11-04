import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:planner_app/entities/Member.dart';
import 'package:planner_app/entities/Workout/Workout.dart';
import 'package:planner_app/entities/Workout/WorkoutPlan.dart';
import 'package:planner_app/screens/SignIn.dart';

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
Future<List<Member>> getPlanerMembers(
    {OrderBy orderBy, int days, String text = ""}) {
  return ref.child("Customers").once().then((DataSnapshot snapshot) {
    List<Member> members = new List<Member>();

    if (snapshot.value != null) {
      Map<String, dynamic> mapOfMaps = Map.from(snapshot.value);

      mapOfMaps.values.forEach((value) {
        //print(Map.from(value));
        members.add(Member.fromMember(Map.from(value)));
      });
    }

    print("the length:${members.length}");
    return members;
  });
}

Future<List> getInvalidPlans({int days = 3}) async {
  return getPlanerMembers().then((List<Member> members) {
    List invPlansWithMembers = new List();
    for (Member member in members) {
      List<WorkoutPlan> invPlans = member.getInvalidPlans();
      if (invPlans != null)
        invPlansWithMembers.add([member, member.getInvalidPlans()]);
    }
    return invPlansWithMembers;
  });
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
      print(mapOfMaps.entries.toList()[0].value);

      return mapOfMaps.entries.toList()[0];
    }
    //showAlertDialog(context, "User Not Found!");
    return null;
  });
}

addPlanToCustomer(WorkoutPlan plan, Member member) {
  member.addNewPlan(plan);
  member.changeCurrentPlanTo(plan);
  ref
      .child("Customers")
      .child(member.id)
      .child("plansHistory")
      .orderByChild("currentPlan")
      .equalTo(true)
      .limitToFirst(1)
      .once()
      .then((DataSnapshot snapshot) {
    if (snapshot.value != null) {
      print("not null ${snapshot.value}");
      return snapshot.key;
    }
    return null;
  }).then((String key) {
    if (key != null) {
      ref
          .child("Customers")
          .child(member.id)
          .child("plansHistory")
          .child(key)
          .update({"currentPlan": false});
    }
  }).then((value) {
    ref
        .child("Customers")
        .child(member.id)
        .child("plansHistory")
        .set(member.getPlansHistoryJson());
  });
}

Future<List<WorkoutPlan>> getAllPremadePlans(
    {MapEntry<String, dynamic> usrJson}) {
  print("the id ${SignIn.planner.id}");
  return ref
      .child(SignIn.planner.id)
      .child("PremadePlans")
      .once()
      .then((DataSnapshot snapshot) {
    if (snapshot.value != null) {
      Map<String, dynamic> mapOfMaps = Map.from(snapshot.value);
      premadePlans.clear();
      mapOfMaps.entries.forEach((entry) {
        premadePlans
            .add(WorkoutPlan.getFromJson(Map.from(entry.value), entry.key));
      });
      return premadePlans;
    }
    return null;
  });
}

//TODO this
List<Workout> getAllWorkouts(WorkoutType muscleName) {
  Workout workout1 = new Workout(null, null, null, null, null);
  workout1.gifPath = 'assets/images/workout.gif';
  workout1.workoutName = 'first';
  workout1.content = 'content';
  workout1.sideNote = 'sidenote';
  workout1.type = WorkoutType.Shoulders;

  Workout workout = new Workout(null, null, null, null, null);
  workout.gifPath = 'assets/images/workout.gif';
  workout.workoutName = 'name';
  workout.content = 'content';
  workout.sideNote = 'sidenote';
  workout.type = WorkoutType.Stretching;

  Workout workout2 = new Workout(null, null, null, null, null);
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

addAsAPremadePlan(WorkoutPlan plan) {
  String key = plan.getKey();

  ref
      .child(SignIn.planner.id)
      .child("PremadePlans")
      .update({key: plan.getJson()});
}

void updatePremadePlan(WorkoutPlan plan) {
  String key = plan.getKey();
  ref
      .child(SignIn.planner.id)
      .child("PremadePlans")
      .update({key: plan.getJson()});
}

void updateUserPlan(WorkoutPlan plan, Member user) {
  String key = plan.getKey();
  ref
      .child("Customers")
      .child(user.id)
      .child("plansHistory")
      .update({key: plan.getJson()});
}

void RemovePlan(WorkoutPlan plan, {Member member = null}) {
  if (member != null) {
    member.plansHistory.remove(plan);
    String key = plan.getKey();
    ref
        .child("Customers")
        .child(member.id)
        .child("plansHistory")
        .child(key)
        .remove();
  } else {
    String key = plan.getKey();
    ref.child(SignIn.planner.id).child("PremadePlans").child(key).remove();
  }
}
