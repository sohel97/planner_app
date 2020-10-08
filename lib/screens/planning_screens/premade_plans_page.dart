import 'package:flutter/material.dart';
import 'package:planner_app/entities/WorkoutPlan.dart';
import 'package:planner_app/screens/planning_screens/edit_workout_schedule_page.dart';
import 'package:planner_app/services/firebase_management.dart';

import '../../constants.dart';
import 'add_workout_schedule_page.dart';

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

class PremadePlansPage extends StatefulWidget {
  PremadePlansPage({Key key, this.userJsn}) : super(key: key);
  MapEntry<String, dynamic> userJsn;
  @override
  _PremadePlansPageState createState() => new _PremadePlansPageState();
}

class _PremadePlansPageState extends State<PremadePlansPage> {
  TextEditingController controller = new TextEditingController();
  List<WorkoutPlan> plans;
  @override
  void initState() {
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditWorkoutSchedulePage(snapshot.data
                                            .elementAt(position))));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddWorkoutSchedulePage()))
              .then((value) {
            setState(
              () {},
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
