import 'package:flutter/material.dart';
import 'package:go_quick_app/app.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/utils/constants.dart';
import 'package:go_quick_app/views/login/login_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoginViewModel())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appTitle,
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: const GoQuickApp()),
    );
  }
}
