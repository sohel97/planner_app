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
const stringToType = {
  "WorkoutType.Shoulders": WorkoutType.Shoulders,
  "WorkoutType.Back": WorkoutType.Back,
  "WorkoutType.Arms": WorkoutType.Arms,
  "WorkoutType.Chest": WorkoutType.Chest,
  "WorkoutType.Abs": WorkoutType.Abs,
  "WorkoutType.Hips": WorkoutType.Hips,
  "WorkoutType.Legs": WorkoutType.Legs,
  "WorkoutType.Aerobic": WorkoutType.Aerobic,
  "WorkoutType.Stretching": WorkoutType.Stretching
};

class Workout {
  WorkoutType type;
  String workoutName;
  String content;
  String gifPath;
  String sideNote;
  Workout(
      {this.type, this.workoutName, this.content, this.gifPath, this.sideNote});
  Workout.getFromJson(var json) {
    type = stringToType[json["type"]];
    workoutName = json["workoutName"];
    content = json["content"];
    gifPath = json["gifPath"];
    sideNote = json["sideNote"];
  }

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
