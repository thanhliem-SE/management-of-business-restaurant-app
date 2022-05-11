import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/ban_service.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';

class RequestOrderViewModel extends ChangeNotifier {
  bool isInit = false;
  List<Ban> _listBan = [];
  int _numTable = 0;
  String _viTriBanTrong = 'Tầng Trệt';

  getViTriBanTrong() => _viTriBanTrong;

  setViTriBanTrong(String value) {
    _viTriBanTrong = value;
    notifyListeners();
  }

  getIsInit() {
    return isInit;
  }

  setListBan(List<Ban> listBan) {
    _listBan = listBan;
    notifyListeners();
  }

  getListBan() {
    return _listBan;
  }

  getNumTable() => _numTable;

  setNumTable(int num) {
    _numTable = num;
    notifyListeners();
  }

  getListBanByViTri(String viTri) {
    return _listBan.where((element) => element.viTri == viTri).toList();
  }

  getListBanFromServer() async {
    String token = await Helper.getToken();
    var response = await BanService().getListBan(token);
    if (response is Success) {
      setListBan(response.response as List<Ban>);
    } else {
      return null;
    }
  }

  init() {
    isInit = true;
    getListBanFromServer();
  }

  showHoaDon({required int maSoBan, required BuildContext context}) async {
    String token = await Helper.getToken();
    var response = await HoaDonService().getHoaDonPhucVuTaiBan(token, maSoBan);
    if (response is Success) {
      HoaDon hoaDon = response.response as HoaDon;
      NavigationHelper.push(context: context, page: BillView(hoaDon: hoaDon));
    }
  }

  getBanByNumTable() {
    return _listBan.firstWhere((element) => element.maSoBan == _numTable);
  }

  clear() {
    isInit = false;
    _listBan = [];
    _numTable = 0;
    _viTriBanTrong = 'Tầng Trệt';
  }
}
