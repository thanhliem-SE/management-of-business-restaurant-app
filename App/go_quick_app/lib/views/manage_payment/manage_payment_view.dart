import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/home/home_view.dart';
import 'package:go_quick_app/views/manage_payment/component/xuat_hoa_don_view.dart';
import 'package:go_quick_app/views/manage_payment/manage_payment_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManagePaymentView extends StatelessWidget {
  const ManagePaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ManagePayMentViewModel>(context);
    if (viewModel.isInitialized) {
      return WillPopScope(
        onWillPop: (() async {
          NavigationHelper.pushReplacement(
              context: context, page: const HomeView());
          viewModel.clear();
          return true;
        }),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              appBar: buildAppBar(size, context, viewModel),
              body: viewModel.listHoaDon.length > 0
                  ? ListView.builder(
                      itemCount: viewModel.listHoaDon.length,
                      itemBuilder: (context, index) {
                        HoaDon hoaDon = viewModel.getListHoaDon[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hóa đơn số: ${hoaDon.maHoaDon}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text('Bàn số: ${hoaDon.ban?.maSoBan}'),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.02,
                                  ),
                                  hoaDon.chiTietHoaDons != null
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              hoaDon.chiTietHoaDons?.length,
                                          itemBuilder: (context, index) {
                                            ChiTietHoaDon item =
                                                hoaDon.chiTietHoaDons![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.network(
                                                    item.thucPham!
                                                        .urlHinhAnh![0],
                                                    width: size.width * 0.2,
                                                    height: size.height * 0.1,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.02,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * 0.3,
                                                        child: Text(
                                                          item.thucPham!.ten!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: size.height *
                                                              0.01),
                                                      SizedBox(
                                                        width: size.width * 0.3,
                                                        child: Text(
                                                          NumberFormat(
                                                                      '###,###')
                                                                  .format(item
                                                                      .thucPham!
                                                                      .giaTien!) +
                                                              'đ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .blueGrey),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'x' +
                                                        item.soLuong.toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                      width: size.width * 0.1),
                                                  Text(
                                                    NumberFormat('###,###')
                                                            .format(item
                                                                .thucPham!
                                                                .giaTien) +
                                                        'đ',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : Container(),
                                  SizedBox(
                                    child: Text(
                                      'Tổng tiền: ${hoaDon.tongThanhTien}',
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          onPressed: () async {
                                            await viewModel.updateHoaDon(
                                                context, hoaDon, 'HUY');
                                          },
                                          child: const Text('TỪ CHỐI'),
                                        ),
                                        ElevatedButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          onPressed: () async {
                                            NavigationHelper.push(
                                                context: context,
                                                page: XuatHoaDonView(
                                                  hoaDon: hoaDon,
                                                ));
                                            await viewModel.updateHoaDon(
                                                context, hoaDon, 'DATHANHTOAN');
                                          },
                                          child: const Text('XUẤT HÓA ĐƠN'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: const Center(
                        child: Text(
                          'Trống',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      );
    } else {
      viewModel.initialAsync(context);
      Provider.of<SocketViewModel>(context)
          .setManagePaymentViewModel(viewModel, context);
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
            strokeWidth: 2.0,
          ),
        ),
      );
    }
  }

  AppBar buildAppBar(
      Size size, BuildContext context, ManagePayMentViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          const Text(
            'Quản lý thanh toán',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
          viewModel.clear();
        },
      ),
    );
  }
}
