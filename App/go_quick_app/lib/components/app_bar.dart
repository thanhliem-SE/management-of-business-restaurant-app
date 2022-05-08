import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';

buildAppBar(
    {required BuildContext context,
    required String title,
    List<Widget>? actions,
    viewModel}) {
  Size size = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor: kPrimaryColor,
    title: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: size.height * 0.05,
      ),
      onPressed: () {
        Navigator.pop(context);
        viewModel.clear();
      },
    ),
    actions: actions,
  );
}
