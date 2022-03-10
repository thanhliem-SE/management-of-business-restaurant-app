import 'package:flutter/material.dart';
import 'package:go_quick_app/views/welcome/welcome_view.dart';

class GoQuickApp extends StatefulWidget {
  const GoQuickApp({Key? key}) : super(key: key);

  @override
  _GoQuickAppState createState() => _GoQuickAppState();
}

class _GoQuickAppState extends State<GoQuickApp> {
  @override
  Widget build(BuildContext context) {
    return WelcomeView();
  }
}
