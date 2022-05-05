import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/views/response_order/components/search_order_dialog.dart';
import 'package:go_quick_app/views/select_category/components/search_food_dialog.dart';

class ResponseOrderView extends StatelessWidget {
  const ResponseOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: buildAppBar(size, context),
        body: Container(
          child: TabBarView(
            children: [
              buildTabDangCho(size: size),
              buildTabTiepNhan(size: size),
              buildTabHoanThanh(size: size),
              buildTabDaHuy(size: size),
            ],
          ),
        ),
      ),
    );
  }

  buildTabDangCho({required Size size}) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Hóa đơn #001',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '10ph trước',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://statics.vinpearl.com/com-tam-ngon-o-sai-gon-0_1630562640.jpg',
                  fit: BoxFit.fill,
                  width: size.width * 0.2,
                  height: size.height * 0.1,
                ),
                const Text(
                  'Com tấm',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('x2'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://nghethuat365.com/wp-content/uploads/2021/08/Cach-Nau-Canh-Chua-Ca-Loc-Don-Gian-Ma-Ngon.jpg',
                  fit: BoxFit.fill,
                  width: size.width * 0.2,
                  height: size.height * 0.1,
                ),
                const Text(
                  'Canh chua cá lóc',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('x1'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Hủy'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Tiếp nhận'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildTabTiepNhan({required Size size}) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Hóa đơn #001',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '10ph trước',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://statics.vinpearl.com/com-tam-ngon-o-sai-gon-0_1630562640.jpg',
                  fit: BoxFit.fill,
                  width: size.width * 0.2,
                  height: size.height * 0.1,
                ),
                const Text(
                  'Com tấm (X2)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(Icons.done_outlined),
                //   iconSize: 30,
                //   color: Colors.green,
                // )
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Đã Chế Biến'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://nghethuat365.com/wp-content/uploads/2021/08/Cach-Nau-Canh-Chua-Ca-Loc-Don-Gian-Ma-Ngon.jpg',
                  fit: BoxFit.fill,
                  width: size.width * 0.2,
                  height: size.height * 0.1,
                ),
                const Text(
                  'Canh chua cá lóc (X1)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.done_outlined),
                  iconSize: 30,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildTabHoanThanh({required Size size}) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Hóa đơn #001',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Icon(Icons.done_all_rounded, color: Colors.green, size: 30),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://statics.vinpearl.com/com-tam-ngon-o-sai-gon-0_1630562640.jpg',
                  fit: BoxFit.fill,
                  width: size.width * 0.2,
                  height: size.height * 0.1,
                ),
                const Text(
                  'Com tấm',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('x2'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://nghethuat365.com/wp-content/uploads/2021/08/Cach-Nau-Canh-Chua-Ca-Loc-Don-Gian-Ma-Ngon.jpg',
                  fit: BoxFit.fill,
                  width: size.width * 0.2,
                  height: size.height * 0.1,
                ),
                const Text(
                  'Canh chua cá lóc',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('x1'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildTabDaHuy({required Size size}) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Hóa đơn #001',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Icon(Icons.cancel_outlined, color: Colors.red, size: 30),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://statics.vinpearl.com/com-tam-ngon-o-sai-gon-0_1630562640.jpg',
                  fit: BoxFit.fill,
                  width: size.width * 0.2,
                  height: size.height * 0.1,
                ),
                const Text(
                  'Com tấm',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('x2'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://nghethuat365.com/wp-content/uploads/2021/08/Cach-Nau-Canh-Chua-Ca-Loc-Don-Gian-Ma-Ngon.jpg',
                  fit: BoxFit.fill,
                  width: size.width * 0.2,
                  height: size.height * 0.1,
                ),
                const Text(
                  'Canh chua cá lóc',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('x1'),
              ],
            ),
          ),
        ],
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
                builder: (context) => SearchOrderDialog(),
              );
            },
            icon: Icon(Icons.search))
      ],
      bottom: const TabBar(
        tabs: [
          Tab(
            text: 'Đang chờ',
            icon: Icon(Icons.hourglass_bottom),
          ),
          Tab(
            text: 'Tiếp nhận',
            icon: Icon(Icons.receipt_long),
          ),
          Tab(
            text: 'Hoàn thành',
            icon: Icon(Icons.done_outline_sharp),
          ),
          Tab(
            text: 'Đã hủy',
            icon: Icon(Icons.cancel_outlined),
          ),
        ],
      ),
      title: const Text(
        'Tiếp Nhận Yêu Cầu',
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
}
