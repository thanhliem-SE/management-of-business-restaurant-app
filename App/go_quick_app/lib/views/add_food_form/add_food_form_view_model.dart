import 'package:flutter/material.dart';
import 'package:go_quick_app/models/danh_muc.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/danh_muc_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class AddFoodFormViewModel extends ChangeNotifier {
  bool intiialized = false;
  late List<DanhMuc> danhMucs;
  List<DanhMuc> get getDanhMucs => this.danhMucs;

  set setDanhMucs(List<DanhMuc> danhMucs) => this.danhMucs = danhMucs;

  bool get getIntiialized => this.intiialized;

  set setIntiialized(bool intiialized) => this.intiialized = intiialized;

  Future<void> Init(BuildContext context) async {
    await loadingDanhMucs(context);
    setIntiialized = true;
    notifyListeners();
  }

  Future<void> loadingDanhMucs(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await DanhMucService().getDanhSachDanhMuc(token);
      if (response is Success) {
        danhMucs = response.response as List<DanhMuc>;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách danh mục")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }
}
