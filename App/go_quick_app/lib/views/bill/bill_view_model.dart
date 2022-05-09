import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_hoa_don_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class BillViewModel extends ChangeNotifier {
  bool _isInit = false;
  List<ChiTietHoaDon> _listChiTietHoaDon = [];

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
      setListChiTietHoaDon(response.response as List<ChiTietHoaDon>);
    } else {
      return null;
    }
  }

  init(int maHoaDon) {
    getListChiTietHoaDonFromServer(maHoaDon);
    _isInit = true;
  }

  clear() {
    _isInit = false;
    _listChiTietHoaDon = [];
  }
}
