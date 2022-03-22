import 'package:flutter/material.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/views/home/home_view.dart';
import 'package:go_quick_app/views/login/login_view.dart';
import 'package:go_quick_app/views/login/login_view_model.dart';
import 'package:go_quick_app/views/welcome/welcome_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoQuickApp extends StatefulWidget {
  const GoQuickApp({Key? key}) : super(key: key);

  @override
  _GoQuickAppState createState() => _GoQuickAppState();
}

class _GoQuickAppState extends State<GoQuickApp> {
  @override
  Widget build(BuildContext context) {
    // return checkLogin() ? HomeView() : WelcomeView();
    return FutureBuilder<bool>(
      future: checkLogin(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return HomeView();
        } else {
          return WelcomeView();
        }
      },
    );
  }
}
