import 'package:flutter/material.dart';
import 'package:planner_app/components/member_tile.dart';
import 'package:planner_app/services/firebase_managment.dart';

import '../constants.dart';
import '../entities/Member.dart';

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

class SearchMemberPage extends StatefulWidget {
  @override
  _SearchMemberPageState createState() => new _SearchMemberPageState();
}

class _SearchMemberPageState extends State<SearchMemberPage> {
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
          //TODO future builder and implement search method
          child: ListView(
            children: <Widget>[
              for (Member member in getAllMembers())
                MemberTile(
                  member: member,
                ),
            ],
          ),
        ),
      ],
    );
  }

  onSearchTextChanged(String text) {
    searchText = text;
  }
}
