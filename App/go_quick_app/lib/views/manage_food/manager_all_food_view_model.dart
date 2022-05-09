import 'package:flutter/material.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/danh_muc.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_thuc_pham_service.dart';
import 'package:go_quick_app/services/danh_muc_service.dart';
import 'package:go_quick_app/services/thuc_pham_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class ManageAllFoodViewModel extends ChangeNotifier {
  bool _loading = false;
  bool isInit = false;
  List<DanhMuc>? danhmucs;
  List<ThucPham>? listChiTietThucPham;
  bool get loading => this._loading;

  set loading(bool value) => this._loading = value;

  get getDanhmucs => this.danhmucs;

  void setDanhmucs(List<DanhMuc>? listDanhMuc) async {
    this.danhmucs = danhmucs;
  }

  Future<void> loadingDanhMucs(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await DanhMucService().getDanhSachDanhMuc(token);
      if (response is Success) {
        danhmucs = response.response as List<DanhMuc>;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách danh mục")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> loadingListThucPham(BuildContext context) async {
    try {
      List<ThucPham> chitietthucphams;
      String token = await Helper.getToken();
      var response = await ThucPhamService().getDanhSachThucPham(token);
      if (response is Success) {
        chitietthucphams = response.response as List<ThucPham>;
        if (chitietthucphams.isNotEmpty && chitietthucphams.length > 0) {
          for (var danhmuc in danhmucs!) {
            danhmuc.thucPhamList = [];
            danhmuc.thucPhamList!.addAll(chitietthucphams
                .where((x) => x.danhMuc!.maDanhMuc == danhmuc.maDanhMuc));
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách thực phẩm")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Init(BuildContext context) async {
    if (!isInit) {
      await loadingDanhMucs(context);
      await loadingListThucPham(context);
      notifyListeners();
      isInit = true;
    }
  }
}
