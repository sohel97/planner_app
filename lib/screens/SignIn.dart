import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner_app/components/Alert.dart';
import 'package:planner_app/entities/Member.dart';
import 'package:planner_app/services/Planner.dart';
import 'package:planner_app/services/firebase_management.dart';
import 'package:planner_app/main.dart';

class SignIn extends StatefulWidget {
  static Planner planner;
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<SignIn> {
  String phoneNumber;
  String message = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text(message),
                RaisedButton(
                  child: Text("Verify"),
                  onPressed: () {
                    checkPhoneNumber(phoneNumber, context)
                        .then((MapEntry<String, dynamic> userJsn) {
                      if (userJsn != null) {
                        var auth = FirebaseAuth.instance;
                        auth.verifyPhoneNumber(
                          phoneNumber: phoneNumber,
                          timeout: const Duration(seconds: 5),
                          verificationCompleted:
                              (PhoneAuthCredential credential) async {
                            await auth
                                .signInWithCredential(credential)
                                .then((value) {
                              SignIn.planner =
                                  Planner.fromPlanner(userJsn.value);
                              print(
                                  "Planner first name ${SignIn.planner.firstName}");
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(userJsn: userJsn)));
                            });
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            print(e.toString());
                            print("ERROR!");
                            message = "Invalid Number";
                            showAlertDialog(context, Text(message));
                          },
                          codeSent:
                              (String verificationId, int resendToken) async {
                            SignIn.planner = Planner.fromPlanner(userJsn.value);
                            print(
                                "Planner first name ${SignIn.planner.firstName}");
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MyHomePage(userJsn: userJsn)));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      } else {
                        message = "The Account Does Not Exist";
                        showAlertDialog(context, Text(message));
                      }
                    });
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.black38,
                      height: 50,
                      child: Center(
                        child: TextField(
                          onChanged: (text) {
                            phoneNumber = text;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
