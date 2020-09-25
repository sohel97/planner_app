import 'package:firebase_database/firebase_database.dart';
import 'package:planner_app/entities/Member.dart';
import 'package:planner_app/entities/Workout.dart';
import 'package:planner_app/entities/WorkoutPlan.dart';

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
final ref = FirebaseDatabase().reference().child("Planners").child("Trainers");

getPlanerMembers({OrderBy orderBy, int days, String text = ""}) {
  return ref.once().then((DataSnapshot snapshot) {
    List<Member> members = new List<Member>();

    if (snapshot.value != null) {
      Map<String, dynamic> mapOfMaps = Map.from(snapshot.value);

      mapOfMaps.values.forEach((value) {
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

//TODO this
getAllPremadePlans() {
  List<WorkoutPlan> plans = new List<WorkoutPlan>();
  plans.add(new WorkoutPlan(planName: 'برنامج مبتدئين'));
  plans.add(new WorkoutPlan(planName: 'برنامج للنزول بالوزن'));
  plans.add(new WorkoutPlan(planName: 'برنامج متقدمين'));
  return plans;
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
addAsAPremadePlan(WorkoutPlan plan) {}
void updatePremadePlan(WorkoutPlan plan) {}
