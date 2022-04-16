import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';

buildAppBar(
    {required BuildContext context,
    required String title,
    List<Widget>? actions}) {
  Size size = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor: kPrimaryLightColor,
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
        size: size.height * 0.05,
      ),
      onPressed: () => Navigator.pop(context),
    ),
    actions: actions,
  );
}
