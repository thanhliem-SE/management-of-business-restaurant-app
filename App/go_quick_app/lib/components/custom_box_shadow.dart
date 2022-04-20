import 'package:flutter/material.dart';

BoxShadow customBoxShadow({required MaterialColor color}) {
  return BoxShadow(
    color: color,
    blurRadius: 4.0,
    spreadRadius: 1.0,
    offset: const Offset(
      0.0,
      1.0,
    ),
  );
}
