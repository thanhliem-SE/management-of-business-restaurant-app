import 'package:flutter/material.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';
import 'package:go_quick_app/views/response_order/components/add_note_huy.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:intl/intl.dart';

buildTabHoanThanh(
    {required Size size,
    required List<HoaDon> listHoaDon,
    required Map<int, List<ChiTietHoaDon>> mapListChiTietHoaDon,
    required ResponseOrderViewModel viewModel}) {
  return listHoaDon.length > 0
      ? ListView.builder(
          itemCount: listHoaDon.length,
          itemBuilder: (context, index) {
            HoaDon hoaDon = listHoaDon[index];
            List<ChiTietHoaDon> listChiTietHoaDon =
                mapListChiTietHoaDon[hoaDon.maHoaDon] ?? [];
            return InkWell(
                onLongPress: () => NavigationHelper.push(
                      context: context,
                      page: BillView(hoaDon: hoaDon),
                    ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hóa đơn #${hoaDon.maHoaDon}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            DateFormat('HH:mm').format(hoaDon.createdAt!),
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                        ],
                      ),
                      ListView.builder(
                        itemCount: listChiTietHoaDon.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ChiTietHoaDon item = listChiTietHoaDon[index];
                          return item.daCheBien == true
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.network(
                                            item.thucPham!.urlHinhAnh![0],
                                            fit: BoxFit.fill,
                                            width: size.width * 0.2,
                                            height: size.height * 0.1,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.35,
                                            child: Text(
                                              item.thucPham!.ten! +
                                                  ' x${item.soLuong}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          [
                                            'QUANLY',
                                            'PHUCVU'
                                          ].contains(viewModel.quyenTaiKhoan)
                                              ? item.daPhucVu == true
                                                  ? IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                          Icons.done_outlined),
                                                      iconSize: 30,
                                                      color: Colors.green,
                                                    )
                                                  : ElevatedButton(
                                                      onPressed: () {
                                                        showConfirmDialog(
                                                            context, () {
                                                          viewModel
                                                              .updateTrangThaiDaPhucVu(
                                                                  item);
                                                          Navigator.pop(
                                                              context);
                                                        }, 'Bạn có chắc chắn đã phục vụ món ăn này không?');
                                                      },
                                                      child:
                                                          const Text('Phục Vụ'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.green,
                                                      ),
                                                    )
                                              : Container()
                                        ],
                                      ),
                                      item.nguoiCheBien != null
                                          ? Container(
                                              child: Text('Người chế biến: ' +
                                                  item.nguoiCheBien!
                                                      .tenNhanVien!),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              : Container();
                        },
                      ),
                      Container(
                          width: size.width,
                          height: size.height * 0.003,
                          color: Colors.grey)
                    ],
                  ),
                ));
          },
        )
      : Container();
}
