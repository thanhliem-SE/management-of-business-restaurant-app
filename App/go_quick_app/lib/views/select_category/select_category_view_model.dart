import 'package:flutter/material.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_hoa_don_service.dart';
import 'package:go_quick_app/services/chi_tiet_thuc_pham_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';

class SelectCategoryViewModel extends ChangeNotifier {
  String _tenMonTimKiem = '';
  String _ghiChu = '';
  bool _isInit = false;
  Map<int, int> _soLuongChonMon = {};
  List<ChiTietThucPham> _listChiTietThucPham = [];

  setGhiChu(String value) {
    _ghiChu = value;
    notifyListeners();
  }

  getGhiChu() {
    return _ghiChu;
  }

  get tenMonTimKiem => _tenMonTimKiem;

  setTenMonTimKiem(String value) {
    _tenMonTimKiem = value;
    notifyListeners();
  }

  getListThucPhamByTenMon() {
    List<ChiTietThucPham> listMonTimKiem = [];
    print(_tenMonTimKiem);
    if (_tenMonTimKiem.isNotEmpty) {
      return _listChiTietThucPham
          .where((element) =>
              element.thucPham!.ten!.toLowerCase().contains(_tenMonTimKiem))
          .toList();
    } else {
      return listMonTimKiem;
    }
  }

  getIsInit() => _isInit;

  getSoLuongChonMon(int maMon) {
    return _soLuongChonMon[maMon];
  }

  setSoLuongChonMon(int maChiTietThucPham, int soLuong) {
    _soLuongChonMon[maChiTietThucPham] = soLuong;
    notifyListeners();
  }

  setListChiTietThucPham(List<ChiTietThucPham> listChiTietThucPham) {
    _listChiTietThucPham = listChiTietThucPham;
    listChiTietThucPham.forEach((chiTietThucPham) {
      _soLuongChonMon[chiTietThucPham.maChiTietThucPham!] = 0;
    });
    notifyListeners();
  }

  getListChiTietThucPham() {
    return _listChiTietThucPham;
  }

  getTotalPrice() {
    double totalPrice = 0;
    _listChiTietThucPham.forEach((element) {
      totalPrice += element.thucPham!.giaTien! *
          _soLuongChonMon[element.maChiTietThucPham]!;
    });
    return totalPrice;
  }

  init() {
    _isInit = true;
    getChiTietThucPhamFromServer();
  }

  getChiTietThucPhamFromServer() async {
    String token = await Helper.getToken();
    var response =
        await ChiTietThucPhamService().getChiTietThucPhamHomNay(token);
    if (response is Success) {
      setListChiTietThucPham(response.response as List<ChiTietThucPham>);
    } else {
      return null;
    }
  }

  navigateToHoaDon({required Ban ban, required BuildContext context}) async {
    var response;

    String token = await Helper.getToken();
    NhanVien nguoiLapHoaDon = await Helper.getNhanVienSigned();

    HoaDon hoaDon = HoaDon(
        nguoiLapHoaDon: nguoiLapHoaDon,
        tongThanhTien: getTotalPrice(),
        ban: ban,
        ghiChu: _ghiChu,
        tinhTrang: 'CHO');

    response = await HoaDonService().createHoaDon(token, hoaDon);

    if (response is Success) {
      HoaDon hoaDonCreated = response.response as HoaDon;
      for (int i = 0; i < _listChiTietThucPham.length; i++) {
        var element = _listChiTietThucPham[i];
        if (_soLuongChonMon[element.maChiTietThucPham!]! > 0) {
          await ChiTietHoaDonService().addChiTietHoaDon(
              token,
              ChiTietHoaDon(
                thucPham: element.thucPham,
                soLuong: _soLuongChonMon[element.maChiTietThucPham!],
                hoaDon: hoaDonCreated,
              ));
        }
        if (_listChiTietThucPham.length == i + 1) {
          Navigator.popUntil(context, (route) {
            return route.settings.name == 'RequestOrderView';
          });
          Navigator.pop(context);
          NavigationHelper.push(
              context: context, page: BillView(hoaDon: hoaDonCreated));
          clear();
        }
      }
    }
  }

  clear() {
    _ghiChu = '';
    _tenMonTimKiem = '';
    _isInit = false;
    _soLuongChonMon = {};
    _listChiTietThucPham = [];
  }
}
