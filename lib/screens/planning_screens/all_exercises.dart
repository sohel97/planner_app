import 'dart:io';

import 'package:flutter/material.dart';
import 'package:planner_app/components/alerts/remove_workout_alert.dart';
import 'package:planner_app/components/alerts/show_workout_alert.dart';
import 'package:planner_app/components/scroll_nav_item.dart';
import 'package:planner_app/constants.dart';
import 'package:planner_app/entities/Workout/Workout.dart';
import 'package:planner_app/entities/Workout/WorkoutDay.dart';
import 'package:planner_app/entities/Workout/WorkoutMuscleItem.dart';
import 'package:planner_app/entities/Workout/WorkoutPlan.dart';
import 'package:planner_app/screens/planning_screens/pick_exercise_page.dart';
import 'package:planner_app/screens/planning_screens/workout_day_page.dart';
import 'package:planner_app/screens/planning_screens/workout_information_page.dart';
import 'package:planner_app/services/firebase_management.dart';

import '../../strings.dart';
import 'add_new_exercise.dart';

class AllExercisesPage extends StatefulWidget {
  WorkoutDay workoutDay = new WorkoutDay();

  @override
  AllExercisesPageState createState() {
    return new AllExercisesPageState();
  }
}

class AllExercisesPageState extends State<AllExercisesPage>
    with SingleTickerProviderStateMixin {
  WorkoutPlan plan;
  double maxWidth = 210;
  double minWidth = 70;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  List<Widget> _children;

  bool status = false;

  int dayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                sAllExercises,
                style: kLargeButtonTextStyle,
              ),
            ),
            Container(child: _buildPanel()),
          ],
        ),
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
                          builder: (context) => AddExercisePage(
                                type: workoutMuscleItem.type,
                              ))).then((value) {
                    setState(() {});
                  });
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
