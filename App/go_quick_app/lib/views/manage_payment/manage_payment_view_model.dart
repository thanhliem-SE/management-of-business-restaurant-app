import 'package:flutter/material.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class ManagePayMentViewModel extends ChangeNotifier {
  bool isInitialized = false;
  late List<HoaDon> listHoaDon;
  bool get getIsInitlized => this.isInitialized;

  set setIsInitlized(bool isInitlized) => this.isInitialized = isInitlized;

  get getListHoaDon => this.listHoaDon;

  set setListHoaDon(listHoaDon) => this.listHoaDon = listHoaDon;

  Future<void> initialAsync(BuildContext context) async {
    await loadListHoaDon(context);
    isInitialized = true;
    notifyListeners();
  }

  Future<void> loadListHoaDon(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await HoaDonService().getHoaDonChuaThanhToan(token);
      if (response is Success) {
        listHoaDon = response.response as List<HoaDon>;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lấy danh sách hóa đơn không thành công")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }
}
