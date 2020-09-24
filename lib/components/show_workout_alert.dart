import 'package:flutter/material.dart';

showWorkoutAlert({context, img}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return WorkoutAlert(img: img);
      });
}

class WorkoutAlert extends StatefulWidget {
  final String img;

  WorkoutAlert({this.img});

  @override
  _WorkoutAlertState createState() => _WorkoutAlertState();
}

class _WorkoutAlertState extends State<WorkoutAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Image.asset(
              widget.img,
            ),
          ],
        ));
  }
}
