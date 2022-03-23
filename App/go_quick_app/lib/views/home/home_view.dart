import 'package:flutter/material.dart';
import 'package:go_quick_app/components/nav_bar.dart';
import 'package:go_quick_app/config/palette.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GoQuick',
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Màn hình chính',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: size.height * 0.05),
        ),
      ),
      drawer: NavBar(),
    );
  }
}
