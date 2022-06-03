import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/models/thong_ke_mon_an.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/thuc_pham_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class ThongKeMonAnViewModel extends ChangeNotifier {
  bool isInit = false;
  int yearPicked = DateTime.now().year;
  int monthPicked = DateTime.now().month;
  List<ThucPham> listThucPham = [];
  List<ThongKeMonAn> listThongKeMonAn = [];

  getTongSoLuongByMaThucPham(int maThucPham) {
    for (int i = 0; i < listThongKeMonAn.length; i++) {
      if (listThongKeMonAn[i].maThucPham == maThucPham) {
        return listThongKeMonAn[i].tongSoLuong;
      }
    }
  }

  getThucPhamByMaThucPham(int maThucPham) {
    return listThucPham
        .firstWhere((element) => element.maThucPham == maThucPham);
  }

  init() async {
    String token = await Helper.getToken();

    var response = await ThucPhamService().getDanhSachThucPham(token);
    if (response is Success) {
      listThucPham = response.response as List<ThucPham>;
    }

    response = await ThucPhamService()
        .getThongKeTheoThang(token, monthPicked, yearPicked);
    if (response is Success) {
      listThongKeMonAn = response.response as List<ThongKeMonAn>;
    }

    isInit = true;

    notifyListeners();
  }
}
