import 'package:flutter/material.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/danh_muc.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_thuc_pham_service.dart';
import 'package:go_quick_app/services/danh_muc_service.dart';
import 'package:go_quick_app/services/thuc_pham_service.dart';
import 'package:go_quick_app/utils/helper.dart';

class ManageFoodViewModel extends ChangeNotifier {
  bool _loading = false;
  bool isInit = false;
  List<DanhMuc>? danhmucs;
  List<ChiTietThucPham>? listChiTietThucPham;
  List<ThucPham> listThucPham = <ThucPham>[];
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
      List<ChiTietThucPham> chitietthucphams;
      String token = await Helper.getToken();
      var response =
          await ChiTietThucPhamService().getChiTietThucPhamHomNay(token);
      if (response is Success) {
        chitietthucphams = response.response as List<ChiTietThucPham>;
        if (chitietthucphams.isNotEmpty && chitietthucphams.length > 0) {
          for (var danhmuc in danhmucs!) {
            danhmuc.thucphams = [];
            danhmuc.thucphams!.addAll(chitietthucphams.where(
                (x) => x.thucPham!.danhMuc!.maDanhMuc == danhmuc.maDanhMuc));
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

  CapNhatSoLuong(int soLuong, int maChitietThucPham) {
    for (var item in listChiTietThucPham!) {
      if (item.maChiTietThucPham == maChitietThucPham) {
        item.soLuong = soLuong;
      }
    }
  }

  Future<void> newChiTietThucPhamTrongNgay(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      danhmucs?.clear();
      await loadingDanhMucs(context);
      if (danhmucs!.isNotEmpty) {
        for (var i = 0; i < danhmucs!.length; i++) {
          var response = await ChiTietThucPhamService()
              .taoChiTietHoaDonHomNay(token, danhmucs![i]);
          if (response is Success) {
            danhmucs![i].thucphams = response.response as List<ChiTietThucPham>;
          }
          if (i == danhmucs!.length - 1) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Tạo chi tiết món ăn hôm nay thành công")));
            notifyListeners();
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  BackupDanhMuc() {
    listChiTietThucPham = <ChiTietThucPham>[];
    for (var item in danhmucs!) {
      item.thucphams!.forEach((element) {
        listChiTietThucPham!.add(element);
      });
    }
  }

  Future<void> CancelUpdateSoLuong(BuildContext context) async {
    isInit = false;
    await Init(context);
  }

  Future<void> SaveUpdate(BuildContext context) async {
    try {
      var isSuccess;
      String token = await Helper.getToken();
      for (var item in listChiTietThucPham!) {
        var response =
            await ChiTietThucPhamService().UpdateChiTietThucPham(token, item);
        if (response is Success) {
          isSuccess = true;
          continue;
        } else {
          isSuccess = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Lỗi cập nhật sách thực phẩm")));
          Init(context);
          break;
        }
      }
      if (isSuccess != null && isSuccess) {
        isInit = false;
        Init(context);
        notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Cập nhật thành công")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }
}
