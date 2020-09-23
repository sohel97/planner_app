import 'package:planner_app/entities/Member.dart';
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

getAllMembers({String text}) {
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
}

getAllPremadePlans() {
  List<WorkoutPlan> plans = new List<WorkoutPlan>();
  plans.add(new WorkoutPlan(planName: 'برنامج مبتدئين'));
  plans.add(new WorkoutPlan(planName: 'برنامج للنزول بالوزن'));
  plans.add(new WorkoutPlan(planName: 'برنامج متقدمين'));
  return plans;
}
