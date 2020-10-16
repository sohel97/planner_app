import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:planner_app/entities/WorkoutPlan.dart';
import 'package:planner_app/screens/SignIn.dart';
import 'package:planner_app/screens/SplashScreen.dart';
import 'package:planner_app/screens/member_screens/member_history.dart';
import 'package:planner_app/screens/member_screens/search_member_page.dart';
import 'package:planner_app/screens/planning_screens/invalid_plans.dart';
import 'package:planner_app/screens/planning_screens/premade_plans_page.dart';
import 'package:planner_app/strings.dart';

import 'constants.dart';
import 'entities/Member.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        home: new SplashPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => MyHomePage(),
          '/login': (BuildContext context) => SignIn(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.userJsn}) : super(key: key);
  MapEntry<String, dynamic> userJsn;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static MapEntry<String, dynamic> userJsn;
  static List<Widget> _children;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    userJsn = widget.userJsn;
    _children = [
      SearchMemberPage(),
      InvalidPlansPage(),
      PremadePlansPage(),
      /*
      MemberHistory(
        member: new Member(
          firstName: 'sohel',
          lastName: 'kanaan',
          id: '318303898',
          plansHistory: new List<WorkoutPlan>(),
        ),

      ),
       */
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text(
          sAppName,
          textDirection: kAppDirection,
        ),
        centerTitle: true,
      ),
      body: Directionality(
        child: _children[_selectedIndex],
        textDirection: kAppDirection,
      ),
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
            /*
            new BottomNavigationBarItem(
              icon: const Icon(Icons.remove_circle_outline),
              title: new Text('TEMP'),
            ),

             */
          ]),
    );
  }
}
