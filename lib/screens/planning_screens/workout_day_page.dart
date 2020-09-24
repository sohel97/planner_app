import 'package:flutter/material.dart';
import 'package:planner_app/components/remove_workout_alert.dart';
import 'package:planner_app/components/show_workout_alert.dart';
import 'package:planner_app/entities/Workout.dart';
import 'package:planner_app/entities/WorkoutDay.dart';
import 'package:planner_app/entities/WorkoutMuscleItem.dart';
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
  void initState() {
    //TODO remove this item and load from firebase

    print(widget.workoutDay.workouts.elementAt(0).workouts.length);
    Workout workout = new Workout();
    workout.gifPath = 'assets/images/workout.gif';
    workout.workoutName = 'name';
    workout.content = 'content';
    workout.sideNote = 'sidenote';
    workout.type = WorkoutType.Strength;

    widget.workoutDay.workouts.elementAt(0).workouts.add(workout);
    super.initState();
  }

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
              FlatButton(
                onPressed: () {
                  //TODO addworkout to this list.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PickWorkoutPage(
                                workouts: workoutMuscleItem.workouts,
                                name: workoutMuscleItem.header,
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
              ListView(
                shrinkWrap: true,
                children:
                    workoutMuscleItem.workouts.map<Widget>((Workout workout) {
                  return ListTile(
                    title: Text(workout.workoutName),
                    leading: Image.asset(workout.gifPath),
                    trailing: Text(workout.sideNote),
                    subtitle: Text(workout.content),
                    onTap: () {
                      showWorkoutAlert(context: context, img: workout.gifPath);
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
            ],
          ),
          isExpanded: workoutMuscleItem.isExpanded,
        );
      }).toList(),
    );
  }
}
