import 'package:flutter/material.dart';

showConfirmDialog(BuildContext context, VoidCallback method, String title) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed: () {
      method();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
