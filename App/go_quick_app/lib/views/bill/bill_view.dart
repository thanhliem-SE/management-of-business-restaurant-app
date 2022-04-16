import 'package:flutter/material.dart';
import 'package:go_quick_app/components/app_bar.dart';
import 'package:go_quick_app/models/hoa_don.dart';

class BillView extends StatelessWidget {
  final HoaDon hoaDon;

  const BillView({Key? key, required this.hoaDon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Hóa đơn #' + hoaDon.maHoaDon.toString(),
      ),
      body: Column(
        children: [
          Text('Khách hàng: ' + hoaDon.khachHang.tenKhachHang),
          Text('Người lập hóa đơn: ' + hoaDon.nguoiLapHoaDon.tenNhanVien),
        ],
      ),
    );
  }
}
