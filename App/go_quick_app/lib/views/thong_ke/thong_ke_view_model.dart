import 'package:flutter/material.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_hoa_don_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class ThongKeViewModel extends ChangeNotifier {
  bool isInitialized = false;
  List<HoaDon> hoadons = <HoaDon>[];
  List<HoaDon> hoaDonsBackup = <HoaDon>[];
  int tongTienCacHoaDon = 0;
  List<int> years = [];
  List<int> month = [];
  List<int> day = [];
  List<String> typeView = [];

  Future<void> Init(BuildContext context) async {
    years = [for (var i = 2022; i <= 2100; i += 1) i];
    month = [for (var i = 1; i <= 12; i += 1) i];
    await loadingHoaDon(context);
    await addThanhTienVaoHoaDon(context);
    hoaDonsBackup = hoadons;
    isInitialized = true;
    notifyListeners();
  }

  Future<void> loadingHoaDon(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await HoaDonService().getDanhSachHoaDon(token);
      if (response is Success) {
        hoadons = response.response as List<HoaDon>;
        for (var i = 0; i < hoadons.length; i++) {
          var chiTietHoaDon = await ChiTietHoaDonService()
              .getChiTietHoaDonByMaHoaDon(token, hoadons[i].maHoaDon!);
          if (chiTietHoaDon is Success) {
            hoadons[i].chiTietHoaDons =
                chiTietHoaDon.response as List<ChiTietHoaDon>;
          }
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Lỗi lấy danh sách hóa đơn")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<double> tinhTongTIenHoaDon(BuildContext context, HoaDon hoaDon) async {
    double tongThanhTien = 0;
    for (var i = 0; i < hoaDon.chiTietHoaDons!.length; i++) {
      var thanhTien = hoaDon.chiTietHoaDons![i].soLuong! *
          hoaDon.chiTietHoaDons![i].thucPham!.giaTien!;
      tongThanhTien += thanhTien;
      if (i == hoaDon.chiTietHoaDons!.length - 1) {
        return tongThanhTien;
      }
    }
    return 0;
  }

  Future<void> addThanhTienVaoHoaDon(BuildContext context) async {
    for (var i = 0; i < hoadons.length; i++) {
      hoadons[i].tongThanhTien = await tinhTongTIenHoaDon(context, hoadons[i]);
      if (i == hoadons.length - 1) {
        notifyListeners();
      }
    }
  }

  double tinhTongTien(List<HoaDon> hoaDons) {
    double tong = 0;
    for (var i = 0; i < hoaDons.length; i++) {
      tong += hoaDons[i].tongThanhTien!;
      if (i == hoaDons.length - 1) {
        return tong;
      }
    }
    return 0;
  }

  void clear() {
    hoadons.clear();
    isInitialized = false;
  }

  Future<void> loadFilter(int month, int year, BuildContext context) async {
    await Init(context);
    if (!hoadons
        .any((x) => x.createdAt!.month == month && x.createdAt!.year == year)) {
      hoadons.clear();
    } else {
      for (var i = 0; i < hoadons.length; i++) {
        if (hoadons[i].createdAt!.month != month ||
            hoadons[i].createdAt!.year != year) {
          hoadons.removeAt(i);
        }
      }
    }
    isInitialized = true;
    notifyListeners();
  }

  Future<void> CancelFilter(BuildContext context) async {
    isInitialized = false;
    notifyListeners();
    await Init(context);
  }
}
