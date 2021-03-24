import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:planner_app/components/alerts/remove_workout_alert.dart';
import 'package:planner_app/components/alerts/show_workout_alert.dart';
import 'package:planner_app/entities/Workout/Workout.dart';
import 'package:planner_app/entities/Workout/WorkoutDay.dart';
import 'package:planner_app/entities/Workout/WorkoutMuscleItem.dart';
import 'package:planner_app/screens/planning_screens/pick_exercise_page.dart';

import '../../constants.dart';
import '../../strings.dart';

// ignore: must_be_immutable
class WorkoutDayPage extends StatefulWidget {
  WorkoutDay workoutDay;
  AnimationController animationController;
  WorkoutDayPage({Key key, this.workoutDay, this.animationController})
      : super(key: key);
  @override
  _WorkoutDayPageState createState() => _WorkoutDayPageState();
}

class _WorkoutDayPageState extends State<WorkoutDayPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Center(
            child: Text(
              widget.workoutDay.restDay ? sTrainingDay : sRestDay,
              style: kLargeButtonTextStyle,
            ),
          ),
          Center(
            child: Switch(
              value: widget.workoutDay.restDay,
              onChanged: (value) {
                setState(() {
                  widget.workoutDay.restDay = value;
                });
              },
              activeColor: kButtonsColor,
            ),
          ),
          if (widget.workoutDay.restDay) Container(child: _buildPanel()),
        ],
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.workoutDay.workouts[index].isExpanded = !isExpanded;
        });
      },
      children: widget.workoutDay.workouts
          .map<ExpansionPanel>((WorkoutMuscleItem workoutMuscleItem) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: Image.asset(workoutMuscleItem.iconpic),
              title: Text(workoutMuscleItem.header),
            );
          },
          body: Column(
            children: <Widget>[
              Column(
                children:
                    workoutMuscleItem.workouts.map<Widget>((Workout workout) {
                  return ListTile(
                    title: Text(workout.workoutName),
                    leading:
                        Image.file(new File(workout.gifPath.split('|')[1])),
                    trailing: Text(workout.sideNote),
                    subtitle: Text(workout.content),
                    onTap: () {
                      showWorkoutAlert(
                          context: context, img: workout.gifPath.split('|')[1]);
                    },
                    onLongPress: () {
                      questionAlert(
                          context: context,
                          label: sDeleteWorkoutQuestion,
                          callback: () {
                            setState(() {
                              workoutMuscleItem.workouts.remove(workout);
                              Navigator.of(context).pop();
                            });
                          });
                    },
                  );
                }).toList(),
              ),
              FlatButton(
                onPressed: () {
                  //TODO addworkout to this list.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PickWorkoutPage(
                                workouts: workoutMuscleItem.workouts,
                                type: workoutMuscleItem.type,
                              ))).then((value) {
                    setState(() {});
                  });
                  print('addworkout to ${workoutMuscleItem.header}');
                },
                child: Text(
                  sAddWorkout,
                ),
                color: kButtonsColor,
              ),
            ],
          ),
          isExpanded: workoutMuscleItem.isExpanded,
        );
      }).toList(),
    );
  }
}
