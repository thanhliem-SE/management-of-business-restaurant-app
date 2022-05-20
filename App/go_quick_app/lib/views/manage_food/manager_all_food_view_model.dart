import 'package:flutter/material.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/danh_muc.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_thuc_pham_service.dart';
import 'package:go_quick_app/services/danh_muc_service.dart';
import 'package:go_quick_app/services/thuc_pham_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class ManageAllFoodViewModel extends ChangeNotifier {
  bool isInit = false;
  List<DanhMuc> danhmucs = <DanhMuc>[];
  String quyen = "";
  late List<ThucPham> thucPhamChuaDuyets = <ThucPham>[];
  List<ThucPham> get getThucPhamChuaDuyets => this.thucPhamChuaDuyets;

  set setThucPhamChuaDuyets(List<ThucPham> thucPhamChuaDuyets) =>
      this.thucPhamChuaDuyets = thucPhamChuaDuyets;

  get getDanhmucs => this.danhmucs;

  void setDanhmucs(List<DanhMuc> listDanhMuc) async {
    this.danhmucs = danhmucs;
  }

  Future<void> loadingDanhMucs(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await DanhMucService().getDanhSachDanhMuc(token);
      if (response is Success) {
        danhmucs = response.response as List<DanhMuc>;
        for (var i = 0; i < danhmucs.length; i++) {
          danhmucs[i].thucPhamList =
              await loadingListThucPham(context, danhmucs[i].maDanhMuc!);
          if (i == danhmucs.length - 1) {
            notifyListeners();
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách danh mục")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> getQuyen(BuildContext context) async {
    try {
      TaiKhoan taiKhoan = await Helper.getTaiKhoanSigned();
      if (taiKhoan != null) {
        quyen = taiKhoan.quyen!;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<List<ThucPham>> loadingListThucPham(
      BuildContext context, int maDanhMuc) async {
    List<ThucPham> chitietthucphams = <ThucPham>[];
    try {
      String token = await Helper.getToken();
      var response = await ThucPhamService()
          .getDanhSachThucPhamTheoDanhMuc(token, maDanhMuc);
      if (response is Success) {
        chitietthucphams = response.response as List<ThucPham>;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Lỗi lấy danh sách thực phẩm theo hóa đơn")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
    return chitietthucphams;
  }

  Future<void> Init(BuildContext context) async {
    await loadingDanhMucs(context);
    await getQuyen(context);
    isInit = true;
    notifyListeners();
  }

  void clear() {
    danhmucs.clear();
    isInit = false;
  }
}
