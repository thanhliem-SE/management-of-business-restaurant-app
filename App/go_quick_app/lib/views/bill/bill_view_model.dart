import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/ban_service.dart';
import 'package:go_quick_app/services/chi_tiet_hoa_don_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class BillViewModel extends ChangeNotifier {
  bool _isInit = false;
  List<ChiTietHoaDon> _listChiTietHoaDon = [];
  HoaDon? _hoaDon = null;

  setHoaDon(HoaDon hoaDon) {
    _hoaDon = hoaDon;
    notifyListeners();
  }

  getHoaDon() => _hoaDon;

  getIsInit() => _isInit;

  getListChiTietHoaDon() => _listChiTietHoaDon;

  getTotalPrice() {
    double totalPrice = 0;

    _listChiTietHoaDon.forEach((element) {
      totalPrice += element.soLuong! * element.thucPham!.giaTien!;
    });
    return totalPrice;
  }

  setListChiTietHoaDon(List<ChiTietHoaDon> listChiTietHoaDon) {
    _listChiTietHoaDon = listChiTietHoaDon;
    notifyListeners();
  }

  getListChiTietHoaDonFromServer(int maHoaDon) async {
    String token = await Helper.getToken();
    var response = await ChiTietHoaDonService()
        .getChiTietHoaDonByMaHoaDon(token, maHoaDon);
    if (response is Success) {
      var list = response.response as List<ChiTietHoaDon>;
      list.removeWhere((element) => element.isDeleted == true);
      setListChiTietHoaDon(list);
    } else {
      return null;
    }
  }

  init(int maHoaDon) async {
    String token = await Helper.getToken();
    final response = await HoaDonService().getHoaDonByMaHoaDon(token, maHoaDon);
    if (response is Success) {
      _hoaDon = response.response as HoaDon;
    }
    _isInit = true;
    getListChiTietHoaDonFromServer(maHoaDon);
  }

  clear() {
    _isInit = false;
    _listChiTietHoaDon = [];
  }

  bool kiemTraKhongTiepNhan() {
    bool result = true;
    _listChiTietHoaDon.forEach((element) {
      if (element.khongTiepNhan != null && element.khongTiepNhan!) {
        result = false;
      }
    });
    return result;
  }

  Future<void> updateHoaDon(BuildContext context, HoaDon hoaDon) async {
    try {
      String token = await Helper.getToken();
      hoaDon.tinhTrang = "HUY";
      var response = await HoaDonService().updateHoaDon(token, hoaDon);
      if (response is Success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Hủy hóa đơn thành công")));
        await updateBan(context, hoaDon);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách danh mục")));
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
