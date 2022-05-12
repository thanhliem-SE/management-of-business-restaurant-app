import 'package:flutter/material.dart';
import 'package:go_quick_app/components/app_bar.dart';
import 'package:go_quick_app/components/custom_box_shadow.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/select_category/components/add_note_dialog.dart';
import 'package:go_quick_app/views/select_category/components/list_view_food.dart';
import 'package:go_quick_app/views/select_category/components/search_food_dialog.dart';
import 'package:go_quick_app/views/select_category/select_category_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectCategoryView extends StatelessWidget {
  final HoaDon? hoaDon;
  final List<ChiTietHoaDon>? listChiTietHoaDon;
  const SelectCategoryView({Key? key, this.hoaDon, this.listChiTietHoaDon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requestOrderModel = Provider.of<RequestOrderViewModel>(context);
    final viewModel = Provider.of<SelectCategoryViewModel>(context);

    if (viewModel.getIsInit() == false) {
      viewModel.init();
      if (listChiTietHoaDon != null) {
        viewModel.setListChiTietHoaDon(listChiTietHoaDon!);
      }
    }

    List<ChiTietThucPham> listChiTietThucPham =
        viewModel.getListChiTietThucPham();

    List<ChiTietThucPham> listFoodTab = listChiTietThucPham
        .where(
            (element) => element.thucPham!.danhMuc!.loaiDanhMuc! == 'Thức ăn')
        .toList();
    List<ChiTietThucPham> listDrinkTab = listChiTietThucPham
        .where(
            (element) => element.thucPham!.danhMuc!.loaiDanhMuc! == 'Thức uống')
        .toList();
    List<ChiTietThucPham> listSnackTab = listChiTietThucPham
        .where((element) =>
            element.thucPham!.danhMuc!.loaiDanhMuc! == 'Tráng miệng')
        .toList();
    List<ChiTietThucPham> listOtherTab = listChiTietThucPham
        .where((element) => element.thucPham!.danhMuc!.loaiDanhMuc! == 'Khác')
        .toList();

    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: buildAppBar(size, context, viewModel),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height * 0.7,
                child: TabBarView(
                  children: [
                    getFoodTab(listChiTietThucPham: listFoodTab),
                    getDrinkTab(listChiTietThucPham: listDrinkTab),
                    getSnackTab(listChiTietThucPham: listSnackTab),
                    getOtherTab(listChiTietThucPham: listOtherTab)
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Container(
                        color: Colors.white,
                        width: size.width * 0.5,
                        height: size.height * 0.05,
                        alignment: Alignment.center,
                        child: Text(
                          'Tổng tiền: ' +
                              NumberFormat('###,###')
                                  .format(viewModel.getTotalPrice()) +
                              ' đ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          viewModel.getTotalPrice() > 0
                              ? showConfirmDialog(context, () {
                                  if (hoaDon == null) {
                                    viewModel.navigateToHoaDon(
                                        ban: requestOrderModel
                                            .getBanByNumTable(),
                                        context: context);
                                  } else {
                                    viewModel.addOrderToHoaDon(
                                        hoaDon: hoaDon!, context: context);
                                  }
                                  requestOrderModel.clear();
                                }, 'Bạn có xác nhận đặt món')
                              : showAlertDialog(
                                  context: context,
                                  title: 'Đặt Món Thất Bại',
                                  message:
                                      'Vui lòng chọn ít nhất 1 món ăn để đặt món');
                        },
                        child: Container(
                          color: kPrimaryColor,
                          width: size.width * 0.5,
                          height: size.height * 0.06,
                          alignment: Alignment.center,
                          child: const Text(
                            'Xác Nhận',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(
      Size size, BuildContext context, SelectCategoryViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      bottom: const TabBar(
        tabs: [
          Tab(
            text: 'Thức ăn',
            icon: Icon(Icons.fastfood),
          ),
          Tab(
            text: 'Thức uống',
            icon: Icon(Icons.local_cafe),
          ),
          Tab(
            text: 'Tráng miệng',
            icon: Icon(Icons.cake_outlined),
          ),
          Tab(
            text: 'Khác',
            icon: Icon(Icons.other_houses_outlined),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => (SearchFoodDialog()),
            );
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => (AddNoteDialog()),
            );
          },
          icon: const Icon(Icons.note_add_outlined),
        ),
        IconButton(
            onPressed: () {
              viewModel.init();
            },
            icon: Icon(Icons.refresh))
      ],
      title: const Text(
        'Danh Sách Món',
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: size.height * 0.05,
        ),
        onPressed: () {
          Navigator.pop(context);
          viewModel.clear();
        },
      ),
    );
  }

  getFoodTab({required List<ChiTietThucPham> listChiTietThucPham}) {
    return ListViewFood(
      listChiTietThucPham: listChiTietThucPham,
    );
  }

  getSnackTab({required List<ChiTietThucPham> listChiTietThucPham}) {
    return ListViewFood(
      listChiTietThucPham: listChiTietThucPham,
    );
  }

  getDrinkTab({required List<ChiTietThucPham> listChiTietThucPham}) {
    return ListViewFood(
      listChiTietThucPham: listChiTietThucPham,
    );
  }

  getOtherTab({required List<ChiTietThucPham> listChiTietThucPham}) {
    return ListViewFood(
      listChiTietThucPham: listChiTietThucPham,
    );
  }
}
