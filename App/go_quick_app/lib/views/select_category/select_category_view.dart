import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';

class SelectCategoryView extends StatelessWidget {
  final int numCustomer;
  final String numTable;
  const SelectCategoryView(
      {Key? key, required this.numTable, required this.numCustomer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('YÊU CẦU ĐẶT MÓN'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: kPrimaryLightColor,
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
              color: Colors.white,
              width: size.width * 0.9,
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people,
                    color: kPrimaryColor,
                    size: size.width * 0.1,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    '$numCustomer',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(width: size.width * 0.3),
                  Icon(
                    Icons.chair,
                    color: kPrimaryColor,
                    size: size.width * 0.1,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    '$numTable',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
