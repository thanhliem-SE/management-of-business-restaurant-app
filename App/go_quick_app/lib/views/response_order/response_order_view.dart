import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/views/response_order/components/search_order_dialog.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:provider/provider.dart';

import 'components/build_tab_dang_cho.dart';

class ResponseOrderView extends StatelessWidget {
  const ResponseOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ResponseOrderViewModel>(context);

    if (viewModel.getIsInit() == false) {
      viewModel.init();
    }

    List<HoaDon> listHoaDon = viewModel.getListHoaDon();
    Map<int, List<ChiTietHoaDon>> mapListChiTietHoaDon =
        viewModel.getMapChiTietHoaDon();

    listHoaDon.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: buildAppBar(size, context, viewModel),
        body: Container(
          child: TabBarView(
            children: [
              buildTabDangCho(
                  size: size,
                  listHoaDon: listHoaDon
                      .where((element) => element.tinhTrang == 'CHO')
                      .toList(),
                  mapListChiTietHoaDon: mapListChiTietHoaDon,
                  viewModel: viewModel),
              buildTabTiepNhan(size: size),
              buildTabHoanThanh(size: size),
              buildTabDaHuy(size: size),
            ],
          ),
        ),
      ),
    );
  }

  buildTabTiepNhan({required Size size}) {
    return Container(
      padding: const EdgeInsets.all(10),
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
                  icon: const Icon(Icons.done_outlined),
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
      padding: const EdgeInsets.all(10),
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
      padding: const EdgeInsets.all(10),
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

  AppBar buildAppBar(
      Size size, BuildContext context, ResponseOrderViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const SearchOrderDialog(),
            );
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            viewModel.init();
          },
          icon: const Icon(Icons.refresh),
        ),
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
        onPressed: () {
          viewModel.clear();
          Navigator.pop(context);
        },
      ),
    );
  }
}
