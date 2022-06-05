import 'package:flutter/material.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';
import 'package:go_quick_app/views/response_order/components/add_note_huy.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:intl/intl.dart';

buildTabDangCho(
    {required Size size,
    required List<HoaDon> listHoaDon,
    required Map<int, List<ChiTietHoaDon>> mapListChiTietHoaDon,
    required ResponseOrderViewModel viewModel}) {
  listHoaDon.sort((a, b) => (a.createdAt ?? DateTime.now())
      .compareTo((b.createdAt ?? DateTime.now())));
  return listHoaDon.isNotEmpty
      ? ListView.builder(
          itemCount: listHoaDon.length,
          itemBuilder: (context, index) {
            HoaDon hoaDon = listHoaDon[index];
            List<ChiTietHoaDon> listChiTietHoaDon =
                mapListChiTietHoaDon[hoaDon.maHoaDon]
                        ?.where((element) =>
                            element.daCheBien == false &&
                            element.isDeleted == false)
                        .toList() ??
                    [];
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
                          'Hóa đơn #' + '${hoaDon.maHoaDon}',
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
                        var item = listChiTietHoaDon[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                item.thucPham!.urlHinhAnh![0],
                                fit: BoxFit.fill,
                                width: size.width * 0.2,
                                height: size.height * 0.1,
                              ),
                              Text(
                                item.thucPham!.ten!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'x${item.soLuong}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    hoaDon.ghiChu == null || hoaDon.ghiChu == ''
                        ? Container()
                        : Text(
                            'Ghi chú: ' + hoaDon.ghiChu!,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                    ['QUANLY', 'CHEBIEN'].contains(viewModel.quyenTaiKhoan) &&
                            listHoaDon[0].maHoaDon == hoaDon.maHoaDon
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AddNoteCancelDialog(
                                            hoaDon: hoaDon,
                                          ));
                                },
                                child: const Text('Không tiếp nhận'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showConfirmDialog(context, () {
                                    viewModel.updateTrangThaiHoaDon(
                                        hoaDon, 'DANGCHEBIEN');
                                    Navigator.pop(context);
                                  }, 'Bạn có muốn tiếp nhận hóa đơn này?');
                                },
                                child: const Text('Tiếp nhận'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                        width: size.width,
                        height: size.height * 0.003,
                        color: Colors.grey)
                  ],
                ),
              ),
            );
          },
        )
      : Container();
}
