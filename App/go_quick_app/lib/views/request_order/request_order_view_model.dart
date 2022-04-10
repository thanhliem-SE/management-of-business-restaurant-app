import 'package:flutter/foundation.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class RequestOrderViewModel extends ChangeNotifier {
  int? _numCustomer;
  int? _numTable;
  List<HoaDon> _listHoaDon = [];
  bool _isInit = false;

  get isInit => _isInit;

  setListHoaDon(List<HoaDon> listHoaDon) {
    _listHoaDon = listHoaDon;
    notifyListeners();
  }

  getListHoaDon() => _listHoaDon;

  setNumCustomer(int? numCustomer) {
    _numCustomer = numCustomer;
    notifyListeners();
  }

  getNumCustomer() => _numCustomer;

  setNumTable(int? numTable) {
    _numTable = numTable;
    notifyListeners();
  }

  getNumTable() => _numTable;

  init() async {
    String token = await Helper.getToken();
    var response = await HoaDonService().getHoaDonChuaThanhToan(token);
    if (response is Success) {
      _isInit = true;
      setListHoaDon(response.response as List<HoaDon>);
    }
    if (response is Failure) {
      return null;
    }
  }
}
