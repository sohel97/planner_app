import 'package:flutter/material.dart';
import 'package:planner_app/constants.dart';
import 'package:planner_app/entities/Member.dart';
import 'package:planner_app/entities/WorkoutPlan.dart';
import 'package:planner_app/services/validators.dart';

import '../../strings.dart';

class WorkoutInformationPage extends StatefulWidget {
  final WorkoutPlan workoutPlan;
  final Member member;
  bool isCurrentPlan = true;
  WorkoutInformationPage({this.workoutPlan, this.member});

  @override
  _WorkoutInformationPageState createState() => _WorkoutInformationPageState();
}

class _WorkoutInformationPageState extends State<WorkoutInformationPage> {
  int duration;
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    duration = widget.workoutPlan.endDate
        .difference(widget.workoutPlan.startDate)
        .inDays;
    widget.isCurrentPlan = widget.workoutPlan.currentPlan;
    selectedDate = widget.workoutPlan.startDate;
    super.initState();
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        widget.workoutPlan.startDate = selectedDate;
      });
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
              initialValue: widget.workoutPlan.planName,
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
              initialValue: widget.workoutPlan.planDescription != null
                  ? widget.workoutPlan.planDescription
                  : '',
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
            widget.member != null
                ? Column(
                    children: <Widget>[
                      CheckboxListTile(
                        title: Text(sCurrentPlan),
                        value: widget.isCurrentPlan,
                        onChanged: (newValue) {
                          setState(() {
                            widget.workoutPlan.currentPlan = newValue;
                            widget.isCurrentPlan = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      )
                    ],
                  )
                : SizedBox(
                    height: 1.0,
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  sPlanStartDate,
                  style: kLabelTextStyle,
                ),
                Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.0,
                ),
                RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    sSelectDate,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  color: kButtonsColor,
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
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
