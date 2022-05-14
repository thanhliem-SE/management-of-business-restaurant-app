import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/ban_service.dart';
import 'package:go_quick_app/services/chi_tiet_hoa_don_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class ManagePayMentViewModel extends ChangeNotifier {
  bool isInitialized = false;
  late List<HoaDon> listHoaDon;
  bool get getIsInitlized => this.isInitialized;

  set setIsInitlized(bool isInitlized) => this.isInitialized = isInitlized;

  get getListHoaDon => this.listHoaDon;

  set setListHoaDon(listHoaDon) => this.listHoaDon = listHoaDon;

  Future<void> initialAsync(BuildContext context) async {
    await loadListHoaDon(context);
    isInitialized = true;
    notifyListeners();
  }

  Future<void> loadListHoaDon(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await HoaDonService().getHoaDonChuaThanhToan(token);
      if (response is Success) {
        listHoaDon = response.response as List<HoaDon>;
        for (int i = 0; i < listHoaDon.length; i++) {
          var hoadon = listHoaDon[i];
          if (hoadon.thanhToan == null) {
            listHoaDon.removeAt(i);
          } else {
            listHoaDon[i].chiTietHoaDons =
                await loadChiTietHoadon(context, hoadon);
            listHoaDon[i].tongThanhTien =
                await tinTongTienHoaDon(listHoaDon[i]);
          }
          if (i == listHoaDon.length - 1) {
            notifyListeners();
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lấy danh sách hóa đơn không thành công")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<List<ChiTietHoaDon>> loadChiTietHoadon(
      BuildContext context, HoaDon hoaDon) async {
    List<ChiTietHoaDon> chitiethoadons = <ChiTietHoaDon>[];
    try {
      String token = await Helper.getToken();
      var response = await ChiTietHoaDonService()
          .getChiTietHoaDonByMaHoaDon(token, hoaDon.maHoaDon!);
      if (response is Success) {
        chitiethoadons = response.response as List<ChiTietHoaDon>;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách danh mục")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
    return chitiethoadons;
  }

  void clear() {
    isInitialized = false;
    listHoaDon.clear();
  }

  Future<double> tinTongTienHoaDon(HoaDon hoaDon) async {
    double tongtien = 0;
    if (hoaDon.chiTietHoaDons != null) {
      hoaDon.chiTietHoaDons!.forEach((element) async {
        tongtien = (tongtien + (element.soLuong! * element.thucPham!.giaTien!))
            as double;
        hoaDon.tongThanhTien = tongtien;
      });
    }
    return tongtien;
  }

  Future<void> updateHoaDon(
      BuildContext context, HoaDon hoaDon, String tinhTrang) async {
    try {
      String token = await Helper.getToken();
      hoaDon.tinhTrang = tinhTrang;
      var response = await HoaDonService().updateHoaDon(token, hoaDon);
      if (response is Success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Thanh toán thành công")));
        await updateBan(context, hoaDon);
        listHoaDon.remove(hoaDon);
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Thanh toán thất bại")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> updateBan(BuildContext context, HoaDon hoaDon) async {
    try {
      String token = await Helper.getToken();
      if (hoaDon.ban != null) {
        Ban ban = hoaDon.ban!;
        ban.tinhTrang = null;
        var response = await BanService().updateBan(token, ban);
        if (response is Success) {
          ban = response.response as Ban;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bàn số ${ban.maSoBan} đã trống")));
          notifyListeners();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("cập nhật bàn thất bại")));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }
}
