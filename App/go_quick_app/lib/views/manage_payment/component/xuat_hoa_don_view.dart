import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/manage_payment/manage_payment_view.dart';
import 'package:go_quick_app/views/manage_payment/manage_payment_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class XuatHoaDonView extends StatelessWidget {
  final HoaDon hoaDon;
  const XuatHoaDonView({Key? key, required this.hoaDon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ManagePayMentViewModel>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: ListView(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      // color: kPrimaryColor,
                      height: constraints.maxWidth * 0.3,
                    ),
                    BienLaiView(
                      hoaDon: hoaDon,
                      constraints: constraints,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          NavigationHelper.pushReplacement(
                              context: context, page: ManagePaymentView());
                        },
                        child: Text('ĐÓNG'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BienLaiView extends StatelessWidget {
  const BienLaiView({
    Key? key,
    required this.hoaDon,
    required this.constraints,
  }) : super(key: key);

  final HoaDon hoaDon;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'GoQuick',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: constraints.maxWidth,
          child: Text(
            'Số 12, đường Nguyễn Văn Bảo, phường 4, quận Gò Vấp, TP.Hồ Chí Minh',
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Điện thoại: 0834696983'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'PHIẾU THANH TOÁN',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Mã hóa đơn: ${hoaDon.maHoaDon}'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: constraints.maxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Giờ tạo: ${DateFormat('HH:mm:ss').format(hoaDon.createdAt!)}',
                ),
                Text(
                    '${DateFormat('dd/MM/yyy HH:mm').format(hoaDon.createdAt!)}'),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: constraints.maxWidth,
              child: Text(
                'Thu ngân: ${hoaDon.nguoiLapHoaDon?.tenNhanVien}',
              ),
            ),
          ),
        ),
        SizedBox(
          width: constraints.maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Text(
                        'Tên món',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'Số lượng',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'Giá',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'Thành tiền',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      )
                    ],
                  ),
                  for (var item in hoaDon.chiTietHoaDons!)
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${item.thucPham?.ten}',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${item.soLuong}',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            NumberFormat('###,###')
                                    .format(item.thucPham?.giaTien) +
                                'đ',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            NumberFormat('###,###').format(
                                    item.soLuong! * (item.thucPham!.giaTien!)) +
                                'đ',
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng tiền: '),
                Text(
                  NumberFormat('###,###').format(hoaDon.tongThanhTien) + 'đ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tiền khách trả: '),
                Text(
                  NumberFormat('###,###')
                          .format(hoaDon.thanhToan?.getTienKhachTra) +
                      'đ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tiền thừa: '),
                Text(
                  NumberFormat('###,###')
                          .format(hoaDon.thanhToan?.getTienThua) +
                      'đ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: constraints.maxHeight,
            child: Center(
              child: Text(
                'Thank you!',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
