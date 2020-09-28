import 'package:flutter/material.dart';
import 'package:planner_app/entities/WorkoutPlan.dart';
import 'package:planner_app/services/firebase_management.dart';

import '../../constants.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     premade_plans_page.dart
|
|  Purpose: trainer could make a premade plans for easy use.
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */

class PickWorkoutScheduleForUser extends StatefulWidget {
  final List<WorkoutPlan> userPlans;

  const PickWorkoutScheduleForUser({Key key, this.userPlans}) : super(key: key);
  @override
  _PickWorkoutScheduleForUserState createState() =>
      new _PickWorkoutScheduleForUserState();
}

class _PickWorkoutScheduleForUserState
    extends State<PickWorkoutScheduleForUser> {
  TextEditingController controller = new TextEditingController();
  List<WorkoutPlan> plans;
  @override
  void initState() {
    plans = getAllPremadePlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Directionality(
          textDirection: kAppDirection,
          child: ListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, position) {
              return InkWell(
                onTap: () {
                  widget.userPlans.add(plans.elementAt(position));
                  Navigator.of(context).pop();
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      plans.elementAt(position).planName,
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
