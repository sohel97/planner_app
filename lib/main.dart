import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:planner_app/screens/member_screens/search_member_page.dart';
import 'package:planner_app/screens/planning_screens/premade_plans_page.dart';
import 'package:planner_app/strings.dart';

import 'constants.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     main.dart
|
|  Purpose:  firebase management.
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: sAppName,
      theme: new ThemeData.dark().copyWith(
          accentColor: kButtonsColor,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: kButtonsColor)),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    FirebaseDatabase()
        .reference()
        .child("Planners")
        .child("Trainers")
        .child("305180309")
        .set({
      "Customers": {"id1": "123456", "id2": "4757483", "id3": "3464323"}
    });
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    SearchMemberPage(),
    Container(),
    PremadePlansPage(),
    // PremadePlansPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          sAppName,
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: new BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            new BottomNavigationBarItem(
              icon: const Icon(Icons.contacts),
              title: new Text(sMembers),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(Icons.access_time),
              title: new Text(sExpiredPlans),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(Icons.fitness_center),
              title: new Text(sTrainingSchedules),
            ),
          ]),
    );
  }
}
