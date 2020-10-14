import 'package:flutter/material.dart';
import 'package:planner_app/entities/Member.dart';
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
  final Member user;

  const PickWorkoutScheduleForUser({Key key, this.user}) : super(key: key);
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
    //plans = getAllPremadePlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Directionality(
          textDirection: kAppDirection,
          child: FutureBuilder(
              future: getAllPremadePlans(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, position) {
                        return InkWell(
                          onTap: () {
                            addPlanToCustomer(
                                snapshot.data.elementAt(position), widget.user);
                            //     widget.user.plansHistory.add(snapshot.data.elementAt(position));
                            Navigator.of(context).pop();
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                snapshot.data.elementAt(position).planName,
                                style: TextStyle(fontSize: 22.0),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                  default:
                    return new ListView();
                }
              }),
        ),
      ),
    );
  }
}
