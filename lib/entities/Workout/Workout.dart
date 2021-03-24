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
  Biceps,
  Chest,
  Abs,
  Hips,
  Legs,
  Aerobic,
  Stretching,
}
const stringToType = {
  "Shoulders": WorkoutType.Shoulders,
  "Back": WorkoutType.Back,
  "Arms": WorkoutType.Arms,
  "Chest": WorkoutType.Chest,
  "Abs": WorkoutType.Abs,
  "Hips": WorkoutType.Hips,
  "Legs": WorkoutType.Legs,
  "Aerobic": WorkoutType.Aerobic,
  "Stretching": WorkoutType.Stretching
};

class Workout {
  WorkoutType type;
  String workoutName;
  String content;
  String gifPath;
  String sideNote;

  Workout(
      this.type, this.workoutName, this.content, this.gifPath, this.sideNote);
  Workout.getFromJson(var json) {
    type = stringToType[json["type"]];
    workoutName = json["workoutName"];
    content = json["content"];
    gifPath = json["gifPath"];
    sideNote = json["sideNote"];
  }
  clone() {
    return new Workout(
        this.type, this.workoutName, this.content, this.gifPath, this.sideNote);
  }

  Map<String, dynamic> getJson() {
    return {
      "type": type.toString(),
      "workoutName": workoutName,
      "content": content,
      "gifPath": gifPath,
      "sideNote": sideNote
    };
  }
}
