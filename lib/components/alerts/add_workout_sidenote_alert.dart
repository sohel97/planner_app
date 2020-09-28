import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner_app/entities/Workout.dart';

import '../../constants.dart';
import '../../strings.dart';

void addWorkoutSideNote({context, Workout workout, List<Workout> workouts}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        if (workout.type == WorkoutType.Aerobic) {
          return AerobicSideNoteAlert(workout: workout, workouts: workouts);
        } else {
          return StrengthSideNoteAlert(workout: workout, workouts: workouts);
        }
      });
}

class StrengthSideNoteAlert extends StatefulWidget {
  final Workout workout;
  final List<Workout> workouts;

  StrengthSideNoteAlert({this.workout, this.workouts});

  @override
  _StrengthSideNoteAlertState createState() => _StrengthSideNoteAlertState();
}

class _StrengthSideNoteAlertState extends State<StrengthSideNoteAlert> {
  int ribs = 0;
  List<int> iter = new List<int>();
  List<int> values = new List<int>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _proccedKey = GlobalKey<FormState>();
    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Directionality(
            textDirection: kAppDirection,
            child: Form(
              key: _proccedKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        sWorkoutRibs,
                        style: kLabelTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            ribs.toString(),
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Color(0xFF8D8E98),
                          activeTrackColor: Colors.white,
                          thumbColor: kButtonsColor,
                          overlayColor: Color(0x29EC801A),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: Slider(
                          value: ribs.toDouble(),
                          min: 0,
                          max: 5,
                          onChanged: (double newValue) {
                            setState(() {
                              ribs = newValue.round();
                              updateList();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: iter.map<Row>((int value) {
                      return Row(
                        children: <Widget>[
                          Text(values[value].toString()),
                          Slider(
                              value: values[value].toDouble(),
                              max: 30,
                              min: 0,
                              label: value.toString(),
                              onChanged: (val) {
                                setState(() {
                                  values[value] = val.round();
                                });
                              }),
                        ],
                      );
                    }).toList(),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)),
                          color: Colors.redAccent,
                          child: Text(sCancel),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(sAdd),
                          onPressed: () {
                            if (_proccedKey.currentState.validate()) {
                              Workout toAdd = new Workout();
                              toAdd.type = widget.workout.type;
                              toAdd.workoutName = widget.workout.workoutName;
                              toAdd.gifPath = widget.workout.gifPath;
                              toAdd.content = widget.workout.content;
                              toAdd.sideNote = values.join(',');
                              widget.workouts.add(toAdd);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  updateList() {
    iter.clear();
    values.clear();
    for (int i = 0; i < ribs; i++) {
      values.add(0);
      iter.add(i);
    }
  }
}

class AerobicSideNoteAlert extends StatefulWidget {
  final Workout workout;
  final List<Workout> workouts;

  AerobicSideNoteAlert({this.workout, this.workouts});

  @override
  _AerobicSideNoteAlertState createState() => _AerobicSideNoteAlertState();
}

class _AerobicSideNoteAlertState extends State<AerobicSideNoteAlert> {
  int duration = 0;

  @override
  Widget build(BuildContext context) {
    final _proccedKey = GlobalKey<FormState>();
    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Form(
            key: _proccedKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      sWorkoutDuration,
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          duration.toString(),
                          style: kNumberTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        thumbColor: kButtonsColor,
                        overlayColor: Color(0x29EC801A),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                        value: duration.toDouble(),
                        min: 0,
                        max: 60,
                        divisions: 12,
                        onChanged: (double newValue) {
                          setState(() {
                            duration = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text(sAdd),
                        onPressed: () {
                          Workout toAdd = new Workout();
                          toAdd.type = widget.workout.type;
                          toAdd.workoutName = widget.workout.workoutName;
                          toAdd.gifPath = widget.workout.gifPath;
                          toAdd.content = widget.workout.content;
                          toAdd.sideNote = duration.toString() + " " + sMinute;
                          widget.workouts.add(toAdd);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        color: Colors.redAccent,
                        child: Text(sCancel),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
