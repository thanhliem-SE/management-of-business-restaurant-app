import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';

class RequestOrderView extends StatefulWidget {
  const RequestOrderView({Key? key}) : super(key: key);

  @override
  State<RequestOrderView> createState() => _RequestOrderViewState();
}

class _RequestOrderViewState extends State<RequestOrderView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Yêu cầu đặt món'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        color: kPrimaryLightColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.grid_view_sharp,
                      size: size.width * 0.12,
                      color: Colors.black,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/icon_table.png',
                    color: Colors.black,
                    width: size.width * 0.2,
                    height: size.height * 0.12,
                    fit: BoxFit.fill,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.table_rows_sharp,
                      size: size.width * 0.12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  cardTableOrder(size, 2, '01', 'full'),
                  cardTableOrder(size, 2, '02', 'null'),
                  cardTableOrder(size, 3, '03', 'full'),
                  cardTableOrder(size, 1, '04', 'null'),
                  cardTableOrder(size, 1, '05', 'full'),
                  cardTableOrder(size, 2, '06', 'null'),
                  cardTableOrder(size, 4, '07', 'null'),
                  cardTableOrder(size, 4, '08', 'null'),
                  cardTableOrder(size, 6, '09', 'full'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container cardTableOrder(
      Size size, int people, String numTable, String status) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {},
        child: status == 'full'
            ? Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: size.width * 0.1,
                      ),
                      SizedBox(
                        width: size.width * 0.08,
                      ),
                      Text(
                        numTable,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    '$people People',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.15,
                      ),
                      Text(
                        numTable,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Icon(
                    Icons.local_restaurant_sharp,
                    size: size.width * 0.15,
                    color: Colors.black,
                  )
                ],
              ),
      ),
    );
  }
}
