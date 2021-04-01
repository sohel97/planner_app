import 'package:flutter/material.dart';
import 'package:planner_app/entities/Workout/Workout.dart';
import 'package:planner_app/screens/planning_screens/gifs_list.dart';
import 'package:planner_app/services/firebase_management.dart';

import '../../constants.dart';
import '../../strings.dart';

class AddExercisePage extends StatefulWidget {
  WorkoutType type;
  AddExercisePage({Key key, this.type}) : super(key: key);
  @override
  AddExercisePageState createState() {
    return new AddExercisePageState();
  }
}

class AddExercisePageState extends State<AddExercisePage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                sAddNewExercise,
                style: kLargeButtonTextStyle,
              ),
            ),
            Container(
                child: Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                      child: Material(
                          child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GifsPage(
                                    type: widget.type,
                                  ))).then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      child: ClipRRect(
                          child: Image.asset('assets/images/shoulders.png')),
                    ),
                  ))),
                  flex: 2,
                ),
                Directionality(
                  textDirection: kAppDirection,
                  child: Flexible(
                    flex: 3,
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: sExerciseName),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء ادخال اسم التمرين';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            sExerciseType,
                            style: TextStyle(
                                color: Colors.grey.withOpacity(1.0),
                                fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            initialValue: typeToString[widget.type],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: sExerciseNotes),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
