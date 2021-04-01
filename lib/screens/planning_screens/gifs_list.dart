import 'package:flutter/material.dart';
import 'package:planner_app/components/member_tile.dart';
import 'package:planner_app/entities/Exercises/exercise_tile.dart';
import 'package:planner_app/entities/Member.dart';
import 'package:planner_app/entities/Workout/Workout.dart';
import 'package:planner_app/services/firebase_management.dart';

import '../../constants.dart';
import '../../strings.dart';

class GifsPage extends StatefulWidget {
  WorkoutType type;

  GifsPage({Key key, this.type}) : super(key: key);
  @override
  GifsPageState createState() {
    return new GifsPageState();
  }
}

class GifsPageState extends State<GifsPage>
    with SingleTickerProviderStateMixin {
  TextEditingController controller = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new Column(
        textDirection: kAppDirection,
        children: <Widget>[
          new Expanded(
              child: FutureBuilder(
                  future: getGifsByType(widget.type),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return ListView(
                          children: <Widget>[
                            for (String filepath in snapshot.data)
                              InkWell(
                                onTap: () {},
                                child: ExerciseTile(
                                  filePath: filepath,
                                ),
                              ),
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
      ),
    );
  }
}
