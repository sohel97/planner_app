import 'package:flutter/material.dart';
import 'package:planner_app/entities/WorkoutPlan.dart';

import '../../constants.dart';
import '../../entities/Member.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     search_member_page.dart
|
|  Purpose:  search a member to give him a plan.
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */

class MemberHistory extends StatefulWidget {
  final Member member;

  MemberHistory({this.member});

  @override
  _MemberHistoryState createState() => new _MemberHistoryState();
}

class _MemberHistoryState extends State<MemberHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: new Column(
        textDirection: kAppDirection,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: Center(
              child: Text(
                widget.member.getFullname(),
                style: kLargeButtonTextStyle,
              ),
            ),
          ),
          new Expanded(
            child: ListView(
              children: <Widget>[
                for (WorkoutPlan plan in widget.member.plansHistory)
                  //TODO make nicer look
                  ListTile(
                    title: Text(plan.planName),
                    subtitle: Text(plan.endDate.toIso8601String() +
                        "\n" +
                        plan.startDate.toIso8601String()),
                    trailing: Text(plan.endDate.toIso8601String()),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => AddWorkoutScheduleToUserPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
