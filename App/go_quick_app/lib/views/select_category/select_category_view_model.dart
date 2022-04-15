import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/dto/hoa_don_dto.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_thuc_pham_service.dart';
import 'package:go_quick_app/services/nhan_vien_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class SelectCategoryViewModel extends ChangeNotifier {
  bool _isInit = false;
  List<ChiTietThucPham> listChiTietThucPham = [];
  List<int> listAmoutFoodOrder = [];
  double _totalPrice = 0;

  getToTalPrice() {
    double sum = 0;
    for (int i = 0; i < listAmoutFoodOrder.length; i++) {
      sum += listChiTietThucPham[i].thucPham.giaTien * listAmoutFoodOrder[i];
    }
    return sum;
  }

  getAmoutFoodOrder(int index) {
    return listAmoutFoodOrder[index];
  }

  setAmoutFoodOrder(int index, int value) {
    listAmoutFoodOrder[index] = value;
    notifyListeners();
  }

  getIsInit() {
    return _isInit;
  }

  setListChiTietThucPham(List<ChiTietThucPham> value) {
    listChiTietThucPham = value;
    listAmoutFoodOrder = List.generate(listChiTietThucPham.length, (index) {
      return 0;
    });
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
