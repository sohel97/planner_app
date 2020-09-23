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
  Strength,
  Aerobic,
  Stretching,
}

class Workout {
  WorkoutType type;
  String workoutName;
  String content;
  String gifPath;
  String _sideNote;

  getJson() {
    return {
      "type": type.toString(),
      "workoutName": workoutName,
      "content": content,
      "gifPath": gifPath,
      "sideNote": _sideNote
    };
  }
}
