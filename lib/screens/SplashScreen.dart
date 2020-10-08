import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planner_app/main.dart';
import 'package:planner_app/services/firebase_management.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  User currentUser;
  @override
  initState() {
    Firebase.initializeApp();
    //irebaseAuth.instance.signOut();
    currentUser = FirebaseAuth.instance.currentUser;
    super.initState();

    if (currentUser == null) {
      new Future.delayed(const Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, "/login"));
    } else
      checkPhoneNumber(currentUser.phoneNumber, context)
          .then((MapEntry<String, dynamic> userJsn) {
        if (userJsn != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyHomePage(userJsn: userJsn)));
        } else {
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, "/login");
        }
      });
    //new Future.delayed(const Duration(seconds: 2), () => checkUser());
  }

  checkUser() {
    //FirebaseAuth.instance.signOut();

    if (currentUser == null) {
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}
