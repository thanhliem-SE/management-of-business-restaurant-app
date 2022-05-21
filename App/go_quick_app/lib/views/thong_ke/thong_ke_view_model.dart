import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/hoa_don_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class ThongKeViewModel extends ChangeNotifier {
  bool isInitialized = false;
  List<HoaDon> hoadons = <HoaDon>[];

  void Init(BuildContext context) async {
    await loadingHoaDon(context);
    isInitialized = true;
    notifyListeners();
  }

  Future<void> loadingHoaDon(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await HoaDonService().getDanhSachHoaDon(token);
      if (response is Success) {
        hoadons = response.response as List<HoaDon>;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Lỗi lấy danh sách hóa đơn")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }
}
