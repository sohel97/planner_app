import 'package:planner_app/entities/Workout.dart';

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
    //TODO add names to String.dart
    restDay = false;
    workouts = new List<WorkoutMuscleItem>();
    workouts.add(new WorkoutMuscleItem(
      header: 'shouldersWorkouts',
      iconpic: 'assets/images/shoulders.png',
      type: WorkoutType.Shoulders,
    ));
    workouts.add(new WorkoutMuscleItem(
      header: 'backWorkouts',
      iconpic: 'assets/images/back.png',
      type: WorkoutType.Back,
    ));
    workouts.add(new WorkoutMuscleItem(
      header: 'armsWorkouts',
      iconpic: 'assets/images/arms.png',
      type: WorkoutType.Arms,
    ));
    workouts.add(new WorkoutMuscleItem(
      header: 'chestWorkouts',
      iconpic: 'assets/images/chest.png',
      type: WorkoutType.Chest,
    ));
    workouts.add(new WorkoutMuscleItem(
      header: 'absWorkouts',
      iconpic: 'assets/images/abs.png',
      type: WorkoutType.Abs,
    ));
    workouts.add(new WorkoutMuscleItem(
      header: 'hipsWorkouts',
      iconpic: 'assets/images/hips.png',
      type: WorkoutType.Hips,
    ));
    workouts.add(new WorkoutMuscleItem(
      header: 'legsWorkouts',
      iconpic: 'assets/images/legs.png',
      type: WorkoutType.Legs,
    ));
    workouts.add(new WorkoutMuscleItem(
        header: 'aerobic',
        iconpic: 'assets/images/aerobic.png',
        type: WorkoutType.Aerobic));
    workouts.add(new WorkoutMuscleItem(
        header: 'stretching',
        iconpic: 'assets/images/stretching.png',
        type: WorkoutType.Stretching));
  }
}
