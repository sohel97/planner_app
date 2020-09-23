import 'package:flutter/cupertino.dart';

import 'WorkoutPlan.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     Member.dart
|
|  Purpose: Member Class
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */

class Member {
  String firstName;
  String lastName;
  String id;
  List<WorkoutPlan> plansHistory;
  Member(
      {@required this.firstName,
      @required this.lastName,
      @required this.plansHistory,
      @required this.id});

  String getFullname() {
    return "${this.firstName} ${this.lastName}";
  }
}
