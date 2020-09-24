/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     Workout.dart
|
|  Purpose:  Workout Class
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */
enum WorkoutType {
  Shoulders,
  Back,
  Arms,
  Chest,
  Abs,
  Hips,
  Legs,
  Aerobic,
  Stretching,
}

class Workout {
  WorkoutType type;
  String workoutName;
  String content;
  String gifPath;
  String sideNote;

  getJson() {
    return {
      "type": type.toString(),
      "workoutName": workoutName,
      "content": content,
      "gifPath": gifPath,
      "sideNote": sideNote
    };
  }
}
