import 'dart:io';

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
class ExerciseTile extends StatelessWidget {
  final String filePath;

  ExerciseTile({@required this.filePath});

  @override
  Widget build(BuildContext context) {
    print(filePath);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white10,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: new ListTile(
                //TODO: change if needed for firebase use
                leading: Image.file(new File(filePath)),
                trailing: Text(filePath),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
