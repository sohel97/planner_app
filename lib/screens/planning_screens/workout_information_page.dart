import 'package:flutter/material.dart';
import 'package:planner_app/constants.dart';
import 'package:planner_app/entities/WorkoutPlan.dart';
import 'package:planner_app/services/validators.dart';

import '../../strings.dart';

class WorkoutInformationPage extends StatefulWidget {
  final WorkoutPlan workoutPlan;
  final GlobalKey<FormState> key;
  WorkoutInformationPage({
    this.workoutPlan,
    this.key,
  });

  @override
  _WorkoutInformationPageState createState() => _WorkoutInformationPageState();
}

class _WorkoutInformationPageState extends State<WorkoutInformationPage> {
  int duration = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Directionality(
          textDirection: kAppDirection,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: textFieldValidator,
              decoration: InputDecoration(labelText: sPlanName),
              onChanged: (text) {
                setState(() {
                  widget.workoutPlan.planName = text;
                });
              },
            ),
          ),
        ),
        Directionality(
          textDirection: kAppDirection,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: textFieldValidator,
              decoration: InputDecoration(labelText: sDescription),
              onChanged: (text) {
                setState(() {
                  widget.workoutPlan.planDescription = text;
                });
              },
              maxLength: 100,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              sPlanDuration,
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
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
              ),
              child: Slider(
                value: duration.toDouble(),
                min: 0,
                max: 30,
                onChanged: (double newValue) {
                  setState(() {
                    duration = newValue.round();
                    widget.workoutPlan.setEndDate(duration);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
