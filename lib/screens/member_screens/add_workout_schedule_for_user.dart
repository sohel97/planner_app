import 'package:flutter/material.dart';
import 'package:planner_app/components/Alert.dart';
import 'package:planner_app/components/alerts/remove_workout_alert.dart';
import 'package:planner_app/components/scroll_nav_item.dart';
import 'package:planner_app/constants.dart';
import 'package:planner_app/entities/Member.dart';
import 'package:planner_app/entities/WorkoutPlan.dart';
import 'package:planner_app/screens/planning_screens/workout_day_page.dart';
import 'package:planner_app/screens/planning_screens/workout_information_page.dart';
import 'package:planner_app/services/firebase_management.dart';

import '../../strings.dart';

class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: sPlanData, icon: Icons.library_books),
  NavigationModel(title: sDayOne, icon: Icons.looks_one),
  NavigationModel(title: sDayTwo, icon: Icons.looks_two),
  NavigationModel(title: sDayThree, icon: Icons.looks_3),
  NavigationModel(title: sDayFour, icon: Icons.looks_4),
  NavigationModel(title: sDayFive, icon: Icons.looks_5),
  NavigationModel(title: sDaySix, icon: Icons.looks_6),
  NavigationModel(title: sDaySeven, icon: Icons.filter_7),
];

class AddWorkoutScheduleForUser extends StatefulWidget {
  final Member member;

  const AddWorkoutScheduleForUser({Key key, this.member}) : super(key: key);
  @override
  AddWorkoutScheduleForUserState createState() {
    return new AddWorkoutScheduleForUserState();
  }
}

class AddWorkoutScheduleForUserState extends State<AddWorkoutScheduleForUser>
    with SingleTickerProviderStateMixin {
  WorkoutPlan plan;
  double maxWidth = 210;
  double minWidth = 70;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  List<Widget> _children;

  bool status = false;

  int dayIndex = 0;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
    plan = new WorkoutPlan();
    _children = [
      new WorkoutInformationPage(
        workoutPlan: plan,
        member: widget.member,
      ),
      new WorkoutDayPage(
          workoutDay: plan.dayOne, animationController: _animationController),
      new WorkoutDayPage(
          workoutDay: plan.dayTwo, animationController: _animationController),
      new WorkoutDayPage(
          workoutDay: plan.dayThree, animationController: _animationController),
      new WorkoutDayPage(
          workoutDay: plan.dayFour, animationController: _animationController),
      new WorkoutDayPage(
          workoutDay: plan.dayFive, animationController: _animationController),
      new WorkoutDayPage(
          workoutDay: plan.daySix, animationController: _animationController),
      new WorkoutDayPage(
          workoutDay: plan.daySeven, animationController: _animationController),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sAddWorkoutSchedule),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
            tooltip: sSave,
            onPressed: () {
              WorkoutPlan overlapPlan =
                  widget.member.checkForOverlapPlans(plan);
              if (overlapPlan != null) {
                showAlertDialog(
                    context,
                    Text(
                        sOverlapPlanMessage +
                            '\n' +
                            overlapPlan.getNameAndPeriod(),
                        textDirection: TextDirection.rtl));
              } else {
                addPlanToCustomer(plan, widget.member);
                questionAlert(
                    context: context,
                    label: sAddAsPremadeWorkout,
                    callback: () {
                      addAsAPremadePlan(plan);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    cancelCallback: () {
                      Navigator.of(context).pop();
                    });
              }
            },
          ),
        ],
      ),
      body: getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    return Material(
      child: Column(children: <Widget>[
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, counter) {
              return ScrollNavItem(
                onTap: () {
                  setState(() {
                    dayIndex = counter;
                  });
                },
                isSelected: dayIndex == counter,
                title: navigationItems[counter].title,
                icon: navigationItems[counter].icon,
              );
            },
            itemCount: navigationItems.length,
          ),
        ),
        Expanded(
          child: Directionality(
              textDirection: kAppDirection, child: _children[dayIndex]),
        ),
      ]),
    );
  }
}
