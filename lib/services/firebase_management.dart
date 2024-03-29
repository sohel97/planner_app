import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager_firebase/flutter_cache_manager_firebase.dart';
import 'package:planner_app/entities/Member.dart';
import 'package:planner_app/entities/Workout/Workout.dart';
import 'package:planner_app/entities/Workout/WorkoutPlan.dart';
import 'package:planner_app/screens/SignIn.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
    List<Member> members = <Member>[];

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
Future<List<Workout>> getAllWorkouts(WorkoutType muscleType) async {
  return FirebaseDatabase()
      .reference()
      .child("Exercises")
      .child(EnumToString.convertToString(muscleType))
      .once()
      .then((DataSnapshot snapshot) async {
    List<Workout> workouts = <Workout>[];

    if (snapshot.value != null) {
      Map<String, dynamic> mapOfMaps = Map.from(snapshot.value);
      for (var entry in mapOfMaps.entries) {
        var path = entry.key.replaceAll('-', '/') + '.gif';
        print(path);
        var file = await FirebaseCacheManager().getSingleFile(path);
        Workout workout1 = new Workout(null, null, null, null, null);
        workout1.gifPath = path + '|' + file.path;
        workout1.workoutName = entry.value['Name'];
        workout1.content = entry.value['Content'];
        workout1.sideNote = entry.value['SideNote'];

        workout1.type = muscleType;
        print(workout1.toString());
        workouts.add(workout1);
      }
    }
    return workouts;
  });
}

Future<List<String>> getGifsByType(WorkoutType exType) async {
  firebase_storage.ListResult result = await firebase_storage
      .FirebaseStorage.instance
      .ref()
      .child('ExercisesGifs')
      .child(typeToString[exType])
      .listAll();
  List<String> filesPaths = <String>[];
  for (firebase_storage.Reference ref in result.items) {
    var file = await FirebaseCacheManager().getSingleFile(ref.fullPath);
    filesPaths.add(file.path);
  }
  return filesPaths;
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
