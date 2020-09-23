import 'package:flutter/material.dart';
import 'package:planner_app/entities/Workout.dart';
import 'package:planner_app/entities/WorkoutDay.dart';
import 'package:planner_app/entities/WorkoutMuscleItem.dart';

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
              ListView(
                shrinkWrap: true,
                children:
                    workoutMuscleItem.workouts.map<ListTile>((Workout workout) {
                  return ListTile(
                    title: Text(workout.workoutName),
                    leading: Image.asset(workout.gifPath),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          print('deleted');
                          //TODO:delete item
                        });
                      },
                    ),
                    onTap: () {
                      //TODO: view full item
                      print('viewfull item');
                    },
                  );
                }).toList(),
              ),
              FlatButton(
                onPressed: () {
                  //TODO addworkout to this list.
                  print('addworkout to ${workoutMuscleItem.header}');
                },
                child: Text(
                  sAddWorkout,
                ),
                color: kButtonsColor,
              ),
            ],
          ),
          // ListTile(
          //     title: Text(workoutMuscleItem.isExpanded.toString()),
          //     subtitle: Text('To delete this panel, tap the trash can icon'),
          //     trailing: Icon(Icons.delete),
          //     onTap: () {
          //       setState(() {});
          //     }),
          isExpanded: workoutMuscleItem.isExpanded,
        );
      }).toList(),
    );
  }
}
