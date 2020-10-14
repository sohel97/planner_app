import 'package:flutter/material.dart';
import 'package:planner_app/entities/Member.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     Member_tile.dart
|
|  Purpose: MemberTile Class
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */
class MemberTile extends StatelessWidget {
  final Member member;

  MemberTile({@required this.member});

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
                trailing: Text(member.id),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
