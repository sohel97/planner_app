import 'package:flutter/material.dart';
import 'package:planner_app/components/InvalidPlanTile.dart';
import 'package:planner_app/components/member_tile.dart';
import 'package:planner_app/entities/WorkoutPlan.dart';
import 'package:planner_app/screens/member_screens/member_history.dart';
import 'package:planner_app/services/firebase_management.dart';

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

class InvalidPlansPage extends StatefulWidget {
  @override
  _InvalidPlansPageState createState() => new _InvalidPlansPageState();
}

class _InvalidPlansPageState extends State<InvalidPlansPage> {
  TextEditingController controller = new TextEditingController();
  String searchText = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      textDirection: kAppDirection,
      children: <Widget>[
        new Container(
          color: Theme.of(context).primaryColor,
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              child: Directionality(
                textDirection: kAppDirection,
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        new Expanded(
            child: FutureBuilder(
                future: getInvalidPlans(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return ListView(
                        children: <Widget>[
                          for (List invplanAndMember in snapshot.data)
                            for (WorkoutPlan invPlan in invplanAndMember[1])
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MemberHistory(
                                              member: invplanAndMember[0])));
                                },
                                child: InvalidPlanTile(
                                  member: invplanAndMember[0],
                                  plan: invPlan,
                                ),
                              )
                        ],
                      );
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                    default:
                      return new ListView();
                  }
                })),
      ],
    );
  }

  onSearchTextChanged(String text) {
    searchText = text;
  }
}
