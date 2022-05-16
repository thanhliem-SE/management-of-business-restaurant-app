import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/views/response_order/components/build_tab_da_che_bien.dart';
import 'package:go_quick_app/views/response_order/components/build_tab_khong_tiep_nhan.dart';
import 'package:go_quick_app/views/response_order/components/search_order_dialog.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:provider/provider.dart';

import 'components/build_tab_dang_cho.dart';
import 'components/build_tab_tiep_nhan.dart';

class ResponseOrderView extends StatelessWidget {
  const ResponseOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ResponseOrderViewModel>(context);

    if (viewModel.getIsInit() == false) {
      viewModel.init();
      Provider.of<SocketViewModel>(context)
          .setResponseOrderViewModel(viewModel);
    }

    List<HoaDon> listHoaDon = viewModel.getListHoaDon();
    Map<int, List<ChiTietHoaDon>> mapListChiTietHoaDon =
        viewModel.getMapChiTietHoaDon();

    listHoaDon.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        viewModel.clear();
        return true;
      },
      child: DefaultTabController(
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
                buildTabTiepNhan(
                    size: size,
                    listHoaDon: listHoaDon
                        .where((element) => element.tinhTrang == 'DANGCHEBIEN')
                        .toList(),
                    mapListChiTietHoaDon: mapListChiTietHoaDon,
                    viewModel: viewModel),
                buildTabHoanThanh(
                    size: size,
                    listHoaDon: listHoaDon
                        .where((element) =>
                            element.tinhTrang == 'DANGCHEBIEN' ||
                            element.tinhTrang == 'DACHEBIEN')
                        .toList(),
                    mapListChiTietHoaDon: mapListChiTietHoaDon,
                    viewModel: viewModel),
                buildTabHuy(
                    size: size,
                    listHoaDon: listHoaDon
                        .where(
                            (element) => element.tinhTrang == 'KHONGTIEPNHAN')
                        .toList(),
                    mapListChiTietHoaDon: mapListChiTietHoaDon,
                    viewModel: viewModel),
              ],
            ),
          ),
        ),
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
            viewModel.init();
          },
          icon: const Icon(Icons.refresh),
        ),
      ],
      bottom: const TabBar(
        tabs: [
          Tab(
            text: 'Đang Chờ',
            icon: Icon(Icons.hourglass_bottom),
          ),
          Tab(
            text: 'Tiếp Nhận',
            icon: Icon(Icons.receipt_long),
          ),
          Tab(
            text: 'Đã Chế Biến',
            icon: Icon(Icons.done_outline_sharp),
          ),
          Tab(
            text: 'Không Tiếp Nhận',
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
