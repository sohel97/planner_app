import 'WorkoutMuscleItem.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     WorkoutDay.dart
|
|  Purpose:  Workout Day Class
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */
class WorkoutDay {
  List<WorkoutMuscleItem> workouts;
  bool restDay;
  WorkoutDay() {
    restDay = false;
    workouts = new List<WorkoutMuscleItem>();
    workouts.add(new WorkoutMuscleItem(
        header: 'shouldersWorkouts', iconpic: 'assets/images/shoulders.png'));
    workouts.add(new WorkoutMuscleItem(
        header: 'backWorkouts', iconpic: 'assets/images/back.png'));
    workouts.add(new WorkoutMuscleItem(
        header: 'armsWorkouts', iconpic: 'assets/images/arms.png'));
    workouts.add(new WorkoutMuscleItem(
        header: 'chestWorkouts', iconpic: 'assets/images/chest.png'));
    workouts.add(new WorkoutMuscleItem(
        header: 'absWorkouts', iconpic: 'assets/images/abs.png'));
    workouts.add(new WorkoutMuscleItem(
        header: 'hipsWorkouts', iconpic: 'assets/images/hips.png'));
    workouts.add(new WorkoutMuscleItem(
        header: 'legsWorkouts', iconpic: 'assets/images/legs.png'));
  }
}
