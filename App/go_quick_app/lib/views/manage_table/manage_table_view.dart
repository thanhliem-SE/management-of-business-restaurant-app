import 'package:flutter/material.dart';
import 'package:go_quick_app/components/custom_box_shadow.dart';
import 'package:go_quick_app/config/palette.dart';

import 'components/add_table_dialog.dart';
import 'components/remove_table_dialog.dart';

class ManageTableView extends StatelessWidget {
  const ManageTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(size, context),
        body: TabBarView(children: [
          buildTabDangPhucVu(size: size),
          buildTabBanTrong(size: size)
        ]),
      ),
    );
  }

  AppBar buildAppBar(Size size, BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => RemoveTableDialog(),
            );
          },
          icon: Icon(Icons.remove_circle_outline_outlined),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddTableDialog(),
            );
          },
          icon: Icon(Icons.add_circle_outline_rounded),
        ),
      ],
      bottom: const TabBar(
        tabs: [
          Tab(
            text: 'Đang phục vụ',
            icon: Icon(Icons.room_service_outlined),
          ),
          Tab(
            text: 'Bàn trống',
            icon: Icon(Icons.chair_outlined),
          ),
        ],
      ),
      title: const Text(
        'Quản Lý Bàn',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: size.height * 0.05,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  buildTabDangPhucVu({required Size size}) {
    return Expanded(
      child: GridView.builder(
        primary: false,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              boxShadow: [
                customBoxShadow(color: Colors.grey),
              ],
              color: kPrimaryColor,
              border: Border.all(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        (index + 6).toString(),
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Phục Vụ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  buildTabBanTrong({required Size size}) {
    return Expanded(
      child: GridView.builder(
        primary: false,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              boxShadow: [
                customBoxShadow(color: Colors.grey),
              ],
              color: Colors.white,
              border: Border.all(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Trống',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
