import 'package:flutter/material.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';
import 'package:go_quick_app/views/response_order/components/add_note_huy.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:intl/intl.dart';

buildTabHuy(
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
                          hoaDon.tinhTrang == "HUY"
                              ? const Icon(Icons.cancel_outlined,
                                  color: Colors.green, size: 30)
                              : const Text(
                                  'Không tiếp nhận',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                        ],
                      ),
                      ListView.builder(
                        itemCount: listChiTietHoaDon.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ChiTietHoaDon item = listChiTietHoaDon[index];
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
                                Text('x${item.soLuong}'),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ));
          },
        )
      : Container();
}
