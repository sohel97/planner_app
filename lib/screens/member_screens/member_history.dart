import 'package:flutter/material.dart';
import 'package:planner_app/components/alerts/remove_workout_alert.dart';
import 'package:planner_app/screens/member_screens/pick_workout_schedule_for_user.dart';
import 'package:planner_app/screens/planning_screens/edit_workout_schedule_page.dart';
import 'package:planner_app/services/Calculations.dart';
import 'package:planner_app/services/firebase_management.dart';

import '../../constants.dart';
import '../../entities/Member.dart';
import '../../strings.dart';
import 'add_workout_schedule_for_user.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Expanded(
            child: ListView.builder(
              itemCount: widget.member.plansHistory.length,
              itemBuilder: (context, position) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditWorkoutSchedulePage(
                                  widget.member,
                                  widget.member.plansHistory
                                      .elementAt(position),
                                )));
                  },
                  onLongPress: () {
                    questionAlert(
                        context: context,
                        label: sDeleteWorkoutPlanQuestion,
                        callback: () {
                          setState(() {
                            RemovePlan(
                                widget.member.plansHistory.elementAt(position),
                                member: widget.member);
                            Navigator.of(context).pop();
                          });
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      leading: Text(
                        widget.member.plansHistory.elementAt(position).planName,
                        style: TextStyle(fontSize: 22.0),
                      ),
                      subtitle: Text(
                        widget.member.plansHistory
                            .elementAt(position)
                            .planDescription,
                      ),
                      trailing: Text(
                        convertDate(widget.member.plansHistory
                            .elementAt(position)
                            .startDate),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: kButtonsColor,
              child: Text(
                sAddPremadePlan,
                style: kLargeButtonTextStyle,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => PickWorkoutScheduleForUser(
                              user: widget.member,
                            )))
                    .then((ans) {
                  setState(() {});
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: kButtonsColor,
              child: Text(
                sAddCustomPlan,
                style: kLargeButtonTextStyle,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => AddWorkoutScheduleForUser(
                              member: widget.member,
                            )))
                    .then((ans) {
                  setState(() {});
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
