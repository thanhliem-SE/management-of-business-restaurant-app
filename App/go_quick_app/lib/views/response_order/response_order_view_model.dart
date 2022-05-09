import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_hoa_don_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class ResponseOrderViewModel extends ChangeNotifier {
  bool _isInit = false;
  List<HoaDon> _listHoaDon = [];
  Map<int, List<ChiTietHoaDon>> _mapChiTietHoaDon = {};
  String _ghiChu = '';

  getListHoaDon() => _listHoaDon;

  getIsInit() => _isInit;

  getMapChiTietHoaDon() => _mapChiTietHoaDon;

  getGhiChu() => _ghiChu;

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
      _mapChiTietHoaDon[maHoaDon] = response.response as List<ChiTietHoaDon>;
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
    }
  }

  init() async {
    String token = await Helper.getToken();
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
    _mapChiTietHoaDon = {};
    _ghiChu = '';
  }
}
