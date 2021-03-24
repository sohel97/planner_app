import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:planner_app/components/alerts/add_workout_sidenote_alert.dart';
import 'package:planner_app/entities/Workout/Workout.dart';
import 'package:planner_app/services/firebase_management.dart';
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
  Future<List<Workout>> allWorkouts;

  @override
  void initState() {
    //allWorkouts = getAllWorkouts(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(sAddWorkout),
          centerTitle: true,
        ),
        body: new Column(children: <Widget>[
          new Expanded(
              child: FutureBuilder(
                  future: getAllWorkouts(WorkoutType.Biceps),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return ListView(children: <Widget>[
                          for (Workout workout in snapshot.data)
                            ListTile(
                              title: Text(workout.workoutName),
                              leading: Image.file(new File(workout.gifPath.split('|')[1])),
                              trailing: Text(workout.type.toString()),
                              subtitle: Text(workout.content),
                              onTap: () {
                                addWorkoutSideNote(
                                    context: context,
                                    workout: workout,
                                    workouts: widget.workouts);
                              },
                            ),
                        ]);
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                      default:
                        return new ListView();
                    }
                  })

              /*
        ListView(
          shrinkWrap: true,
          children:

          allWorkouts.map<ListTile>((Workout workout) {
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

         */
              ),
        ]));
  }
}
