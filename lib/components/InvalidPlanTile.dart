import 'package:flutter/material.dart';
import 'package:planner_app/entities/Member.dart';
import 'package:planner_app/entities/Workout/WorkoutPlan.dart';
import 'package:planner_app/services/Calculations.dart';

class InvalidPlanTile extends StatelessWidget {
  final Member member;
  final WorkoutPlan plan;

  InvalidPlanTile({@required this.member, @required this.plan});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white10,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: new ListTile(
                //TODO: change if needed for firebase use
                leading: new Text(member.getFullname()),
                trailing: Text(
                    plan.planName + '\n Ends: ' + convertDate(plan.endDate)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
