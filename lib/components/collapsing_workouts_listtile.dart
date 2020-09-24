import 'package:flutter/material.dart';
import 'package:planner_app/entities/WorkoutMuscleItem.dart';

class CollapsingWorkoutsListTile extends StatefulWidget {
  AnimationController animationController;
  WorkoutMuscleItem workoutMuscleItem;
  CollapsingWorkoutsListTile({
    @required this.animationController,
    @required this.workoutMuscleItem,
  });

  @override
  _CollapsingWorkoutsListTileState createState() =>
      _CollapsingWorkoutsListTileState();
}

class _CollapsingWorkoutsListTileState
    extends State<CollapsingWorkoutsListTile> {
  Animation<double> widthAnimation, sizedBoxAnimation;
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    widthAnimation =
        Tween<double>(begin: 200, end: 70).animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.blue,
        )
        // ExpansionPanelList(
        //   expansionCallback: (int index, bool isExpanded) {
        //     setState(() {
        //       isExpanded = isExpanded;
        //     });
        //   },
        //   children: widget.workoutMuscleItem.workouts.map((Workout item) {
        //     return ExpansionPanel(
        //       headerBuilder: (BuildContext context, bool isExpanded) {
        //         return ListTile(
        //             leading: Text(item.gifPath),
        //             title: Text(
        //               item.workoutName,
        //               textAlign: TextAlign.left,
        //               style: kLabelTextStyle,
        //             ));
        //       },
        //       isExpanded: isExpanded,
        //       body: Container(),
        //     );
        //   }).toList(),
        // ),
        );
  }
}
