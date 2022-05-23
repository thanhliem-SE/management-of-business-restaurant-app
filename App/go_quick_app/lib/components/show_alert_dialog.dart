import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';

showConfirmDialog(BuildContext context, VoidCallback method, String title) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Hủy"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Đồng ý"),
    onPressed: () {
      method();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
    ),
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

showAlertDialog(
    {required BuildContext context,
    required String title,
    required String message}) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Đóng"),
    onPressed: () {
      if (Navigator.canPop(context)) Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
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
