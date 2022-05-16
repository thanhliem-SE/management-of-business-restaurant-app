import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/thong_bao.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_hoa_don_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/services/thong_bao_service.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/helper.dart';

class ResponseOrderViewModel extends ChangeNotifier {
  bool _isInit = false;
  List<HoaDon> _listHoaDon = [];
  Map<int, List<ChiTietHoaDon>> _mapListChiTietHoaDon = {};
  String _ghiChu = '';
  String _quyenTaiKhoan = '';

  get quyenTaiKhoan => _quyenTaiKhoan;

  getListHoaDon() => _listHoaDon;

  getIsInit() => _isInit;

  getMapChiTietHoaDon() => _mapListChiTietHoaDon;

  getGhiChu() => _ghiChu;

  getListChiTietHonDonByMaHoaDon(int maHoaDon) {
    return _mapListChiTietHoaDon[maHoaDon] ?? [];
  }

  setKhongTiepNhanForChiTietHoaDon(int maHoaDon, int maChiTietHoaDon) {
    var list = _mapListChiTietHoaDon[maHoaDon];
    for (int i = 0; i < list!.length; i++) {
      if (list[i].maChiTietHoaDon == maChiTietHoaDon) {
        list[i].khongTiepNhan = list[i].khongTiepNhan == false ? true : false;
        break;
      }
    }
    notifyListeners();
  }

  setGhiChu(String value) {
    _ghiChu = value;
    notifyListeners();
  }

  setListHoaDon(List<HoaDon> listHoaDon) {
    _listHoaDon = listHoaDon;
    notifyListeners();
  }

  setMapChiTietHoaDonFromListHoaDon(List<HoaDon> listHoaDon) {
    listHoaDon.forEach((hoaDon) {
      setListChiTietHoaDonFromMaHoaDonFromServer(hoaDon.maHoaDon!);
    });
  }

  setListChiTietHoaDonFromMaHoaDonFromServer(int maHoaDon) async {
    String token = await Helper.getToken();
    var response = await ChiTietHoaDonService()
        .getChiTietHoaDonByMaHoaDon(token, maHoaDon);
    if (response is Success) {
      _mapListChiTietHoaDon[maHoaDon] =
          response.response as List<ChiTietHoaDon>;
      notifyListeners();
    } else {
      return [];
    }
  }

  updateTrangThaiHoaDon(HoaDon hoaDon, String trangThai) async {
    String token = await Helper.getToken();
    hoaDon.tinhTrang = trangThai;

    var response = await HoaDonService().updateHoaDon(token, hoaDon);
    if (response is Success) {
      init();
      if (trangThai == "DANGCHEBIEN") {
        ThongBaoService().addThongBao(
            token,
            ThongBao(
                noiDung: "Hóa đơn được tiếp nhận (Bàn ${hoaDon.ban!.soBan})"),
            "PHUCVU");
        SocketViewModel.sendMessage(
            "PHUCVU",
            "Cập nhật phản hồi yêu cầu đặt món",
            "Hóa đơn được tiếp nhận (Bàn ${hoaDon.ban!.soBan})");
      }
      if (trangThai == "KHONGTIEPNHAN") {
        ThongBaoService().addThongBao(
            token,
            ThongBao(
                noiDung:
                    "Hóa đơn không được tiếp nhận vì '${hoaDon.ghiChu}' (Bàn ${hoaDon.ban!.soBan})"),
            "PHUCVU");
        SocketViewModel.sendMessage(
            "PHUCVU",
            "Cập nhật phản hồi yêu cầu đặt món",
            "Hóa đơn không được tiếp nhận vì '${hoaDon.ghiChu}' (Bàn ${hoaDon.ban!.soBan})");
      }
    }
  }

  updateKhongTiepNhanChiTietHoaDon(
      List<ChiTietHoaDon> listChiTietHoaDon) async {
    String token = await Helper.getToken();

    listChiTietHoaDon.forEach((element) {
      if (element.khongTiepNhan == true) {
        ChiTietHoaDonService().updateChiTietHoaDon(token, element);
      }
    });
  }

  updateTrangThaiDaCheBien(ChiTietHoaDon chiTietHoaDon) async {
    NhanVien nguoiCheBien = await Helper.getNhanVienSigned();
    String token = await Helper.getToken();

    chiTietHoaDon.daCheBien = true;
    chiTietHoaDon.nguoiCheBien = nguoiCheBien;

    var response =
        await ChiTietHoaDonService().updateChiTietHoaDon(token, chiTietHoaDon);
    if (response is Success) {
      ThongBaoService().addThongBao(
          token,
          ThongBao(
              noiDung:
                  "${chiTietHoaDon.thucPham!.ten} được chế biến xong, có thể phục vụ tại bàn ${chiTietHoaDon.hoaDon!.ban!.soBan}"),
          "PHUCVU");
      SocketViewModel.sendMessage("PHUCVU", "Cập nhật phản hồi yêu cầu đặt món",
          "${chiTietHoaDon.thucPham!.ten} được chế biến xong, có thể phục vụ tại bàn ${chiTietHoaDon.hoaDon!.ban!.soBan}");
      init();
      checkDaCheBienHoaDon(chiTietHoaDon.hoaDon!.maHoaDon!);
    }
  }

  updateTrangThaiDaPhucVu(ChiTietHoaDon chiTietHoaDon) async {
    NhanVien nguoiCheBien = await Helper.getNhanVienSigned();
    String token = await Helper.getToken();

    chiTietHoaDon.daPhucVu = true;

    var response =
        await ChiTietHoaDonService().updateChiTietHoaDon(token, chiTietHoaDon);
    if (response is Success) {
      ThongBaoService().addThongBao(
          token,
          ThongBao(
              noiDung:
                  "${chiTietHoaDon.thucPham!.ten} đã được phục vụ tại bàn ${chiTietHoaDon.hoaDon!.ban!.soBan}"),
          "PHUCVU");
      SocketViewModel.sendMessage("PHUCVU", "Cập nhật phản hồi yêu cầu đặt món",
          "${chiTietHoaDon.thucPham!.ten} đã được phục vụ tại bàn ${chiTietHoaDon.hoaDon!.ban!.soBan}");
      init();
      checkDaPhucVuHoaDon(chiTietHoaDon.hoaDon!.maHoaDon!);
    }
  }

  checkDaCheBienHoaDon(int maHoaDon) async {
    String token = await Helper.getToken();
    List<ChiTietHoaDon> listChiTietHoaDon = _mapListChiTietHoaDon[maHoaDon]!;
    bool isHoanThanh = true;

    for (int i = 0; i < listChiTietHoaDon.length; i++) {
      if (listChiTietHoaDon[i].daCheBien == false) {
        isHoanThanh = false;
        break;
      }
      if (i == listChiTietHoaDon.length - 1 && isHoanThanh == true) {
        updateTrangThaiHoaDon(listChiTietHoaDon[i].hoaDon!, 'DACHEBIEN');
      }
    }
  }

  checkDaPhucVuHoaDon(int maHoaDon) async {
    String token = await Helper.getToken();
    List<ChiTietHoaDon> listChiTietHoaDon = _mapListChiTietHoaDon[maHoaDon]!;
    bool rs = true;

    for (int i = 0; i < listChiTietHoaDon.length; i++) {
      if (listChiTietHoaDon[i].daPhucVu == false) {
        rs = false;
        break;
      }

      if (i == listChiTietHoaDon.length - 1 && rs == true) {
        updateTrangThaiHoaDon(listChiTietHoaDon[i].hoaDon!, 'CHUATHANHTOAN');
      }
    }
  }

  init() async {
    String token = await Helper.getToken();
    NhanVien nhanVien = await Helper.getNhanVienSigned();
    _quyenTaiKhoan = nhanVien.taiKhoan!.quyen!;
    var response = await HoaDonService().getDanhSachHoaDon(token);
    if (response is Success) {
      _isInit = true;
      setMapChiTietHoaDonFromListHoaDon(response.response as List<HoaDon>);
      setListHoaDon(response.response as List<HoaDon>);
    } else {
      return null;
    }
  }

  clear() {
    _isInit = false;
    _listHoaDon = [];
    _mapListChiTietHoaDon = {};
    _ghiChu = '';
  }
}
