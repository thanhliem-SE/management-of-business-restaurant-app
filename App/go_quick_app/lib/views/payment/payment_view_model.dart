import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/models/thanh_toan.dart';
import 'package:go_quick_app/models/thong_bao.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_hoa_don_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/services/thanh_toan_service.dart';
import 'package:go_quick_app/services/thong_bao_service.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/helper.dart';

class PayMentViewModel extends ChangeNotifier {
  bool isInited = false;
  bool daThanhToan = false;
  bool choThanhToan = false;
  late HoaDon hoaDon;
  late ThanhToan thanhToan;

  bool get getDaThanhToan => this.daThanhToan;

  set setDaThanhToan(bool daThanhToan) => this.daThanhToan = daThanhToan;
  bool get getIsInit => this.isInited;

  set setIsInit(bool isInit) => this.isInited = isInit;

  get getHoaDon => this.hoaDon;

  Future<void> setHoaDon(hoaDon) async => this.hoaDon = hoaDon;

  Future<void> loadChiTietHoadon(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await ChiTietHoaDonService()
          .getChiTietHoaDonByMaHoaDon(token, hoaDon.maHoaDon!);
      if (response is Success) {
        hoaDon.chiTietHoaDons = response.response as List<ChiTietHoaDon>;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách danh mục")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> initialize(HoaDon hoaDon, BuildContext context) async {
    await setHoaDon(hoaDon);
    await loadChiTietHoadon(context);
    thanhToan = new ThanhToan(
      hinhThucThanhToan: "cast",
      tienKhachTra: 0,
    );
    isInited = true;
    if (hoaDon.thanhToan != null && hoaDon.thanhToan!.maThanhToan != null) {
      choThanhToan = true;
    }
    notifyListeners();
  }

  double tinTongTienHoaDon() {
    double tongtien = 0;
    if (hoaDon.chiTietHoaDons != null) {
      hoaDon.chiTietHoaDons!.forEach((element) {
        tongtien = (tongtien + (element.soLuong! * element.thucPham!.giaTien!))
            as double;
        hoaDon.tongThanhTien = tongtien;
      });
    }
    return tongtien;
  }

  void nhapTienKhacTra(double tienKhachTra) {
    thanhToan.setTienKhachTra = tienKhachTra;
    thanhToan.setTienThua = tienKhachTra - tinTongTienHoaDon();
    if (thanhToan.getTienThua >= 0) {
      setDaThanhToan = true;
    } else {
      setDaThanhToan = false;
    }
    notifyListeners();
  }

  Future<ThanhToan?> tienHanhThanhToan(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await ThanhToanService().addThanhToan(token, thanhToan);
      if (response is Success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Thanh toán thành công")));
        return response.response as ThanhToan;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Lỗi lấy thanh toán")));
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<bool> xacNhanThanhToan(BuildContext context) async {
    bool result = false;
    try {
      String token = await Helper.getToken();
      var thanhtoan1 = await tienHanhThanhToan(context);
      if (thanhtoan1?.maThanhToan != null) {
        hoaDon.thanhToan = thanhtoan1;
        hoaDon.tinhTrang = "CHUATHANHTOAN";
        var hoaDonRespone = await HoaDonService().updateHoaDon(token, hoaDon);
        if (hoaDonRespone is Success) {
          HoaDon hoaDon = hoaDonRespone.response as HoaDon;
          choThanhToan = true;
          result = true;
          notifyListeners();
          ThongBaoService().addThongBao(
              token,
              ThongBao(
                noiDung:
                    "Yêu cầu thanh toán mới cần được xử lý tại bàn ${hoaDon.ban!.soBan}",
              ),
              'THUNGAN');
          SocketViewModel.sendMessage("THUNGAN", "Yêu cầu thanh toán mới",
              "Yêu cầu thanh toán mới cần được xử lý tại bàn ${hoaDon.ban!.soBan}");
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Lỗi lấy thanh toán")));
          result = false;
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
      result = false;
    }
    return result;
  }

  void clear() {
    isInited = false;
    daThanhToan = false;
    choThanhToan = false;
    hoaDon = HoaDon();
    thanhToan = ThanhToan();
  }
}
