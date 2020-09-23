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
  String planName;
  String planDescription;
  WorkoutDay dayOne;
  WorkoutDay dayTwo;
  WorkoutDay dayThree;
  WorkoutDay dayFour;
  WorkoutDay dayFive;
  WorkoutDay daySix;
  WorkoutDay daySeven;
  DateTime startDate;
  DateTime endDate;
  WorkoutPlan({this.planName}) {
    dayOne = new WorkoutDay();
    dayTwo = new WorkoutDay();
    dayThree = new WorkoutDay();
    dayFour = new WorkoutDay();
    dayFive = new WorkoutDay();
    daySix = new WorkoutDay();
    daySeven = new WorkoutDay();
    startDate = DateTime.now();
  }

  setEndDate(int duration) {
    //TODO
  }
}
