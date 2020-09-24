import 'package:flutter/material.dart';
import 'package:planner_app/components/add_workout_sidenote_alert.dart';
import 'package:planner_app/entities/Workout.dart';
import 'package:planner_app/services/firebase_managment.dart';
import 'package:planner_app/strings.dart';

// ignore: must_be_immutable
class PickWorkoutPage extends StatefulWidget {
  List<Workout> workouts;
  WorkoutType type;
  PickWorkoutPage({Key key, this.workouts, this.type}) : super(key: key);
  @override
  _PickWorkoutPageState createState() => _PickWorkoutPageState();
}

class _PickWorkoutPageState extends State<PickWorkoutPage> {
  List<Workout> allWorkouts = new List<Workout>();

  @override
  void initState() {
    allWorkouts = getAllWorkouts(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(sAddWorkout),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          children: allWorkouts.map<ListTile>((Workout workout) {
            return ListTile(
              title: Text(workout.workoutName),
              leading: Image.asset(workout.gifPath),
              trailing: Text(workout.type.toString()),
              subtitle: Text(workout.content),
              onTap: () {
                addWorkoutSideNote(
                    context: context,
                    workout: workout,
                    workouts: widget.workouts);
              },
            );
          }).toList(),
        ));
  }
}
