import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../strings.dart';

void questionAlert({context, callback, String label}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return TwoOptionAlert(
          label: label,
          callback: callback,
          leftOption: sYes,
          rightOption: sNo,
        );
      });
}

class TwoOptionAlert extends StatelessWidget {
  final callback;
  final String label;
  final String leftOption;
  final String rightOption;
  TwoOptionAlert(
      {this.callback, this.label, this.leftOption, this.rightOption});
  @override
  Widget build(BuildContext context) {
    final _proccedKey = GlobalKey<FormState>();
    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Form(
            key: _proccedKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(label),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text(leftOption),
                        onPressed: () {
                          if (_proccedKey.currentState.validate()) {
                            callback();
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                        color: Colors.redAccent,
                        child: Text(rightOption),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
