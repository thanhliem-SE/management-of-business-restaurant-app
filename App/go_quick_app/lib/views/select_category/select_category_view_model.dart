import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_thuc_pham_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class SelectCategoryViewModel extends ChangeNotifier {
  bool _isInit = false;
  List<ChiTietThucPham> listChiTietThucPham = [];

  getIsInit() {
    return _isInit;
  }

  setListChiTietThucPham(List<ChiTietThucPham> value) {
    listChiTietThucPham = value;
    notifyListeners();
  }

  getListChiTietThucPham() {
    return listChiTietThucPham;
  }

  init() async {
    String token = await Helper.getToken();
    var response =
        await ChiTietThucPhamService().getChiTietThucPhamHomNay(token);
    if (response is Success) {
      _isInit = true;
      setListChiTietThucPham(response.response as List<ChiTietThucPham>);
    } else {
      return null;
    }
  }
}
