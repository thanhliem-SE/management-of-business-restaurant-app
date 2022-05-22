import 'package:flutter/material.dart';
import 'package:go_quick_app/models/thong_bao.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/thong_bao_service.dart';
import 'package:go_quick_app/services/thuc_pham_service.dart';
import 'package:go_quick_app/utils/helper.dart';

import '../../socket_view_model.dart';

class ConfirmAddFoodViewModel extends ChangeNotifier {
  bool isInit = false;
  List<ThucPham> thucPhamChuaDuyets = <ThucPham>[];
  get getIsInit => this.isInit;

  set setIsInit(isInit) => this.isInit = isInit;

  get getThucPhamChuaDuyets => this.thucPhamChuaDuyets;

  set setThucPhamChuaDuyets(thucPhamChuaDuyets) =>
      this.thucPhamChuaDuyets = thucPhamChuaDuyets;

  Future<void> loadListThucPhamChuaDuyet(BuildContext context) async {
    try {
      String token = await Helper.getToken();
      var response = await ThucPhamService().getDanhSachChuaDuyet(token);
      if (response is Success) {
        thucPhamChuaDuyets = response.response as List<ThucPham>;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách thực phẩm chưa duyệt")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> duyetThucPham(BuildContext context, ThucPham thucPham) async {
    try {
      String token = await Helper.getToken();
      thucPham.trangThai = "DADUYET";
      var response = await ThucPhamService().updateThucPham(token, thucPham);
      if (response is Success) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Đã duyệt món ${thucPham.ten}")));
        thucPhamChuaDuyets.remove(thucPham);
        notifyListeners();
        ThongBaoService().addThongBao(
            token,
            ThongBao(
              noiDung: "${thucPham.ten} đã được duyệt",
            ),
            'CHEBIEN');
        SocketViewModel.sendMessage(
            "CHEBIEN", "Món ăn được duyệt", "${thucPham.ten} đã được duyệt");
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Lỗi cập nhật thực phẩm")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> xoaThucPham(BuildContext context, ThucPham thucPham) async {
    try {
      String token = await Helper.getToken();
      thucPham.isDeleted = true;
      var response = await ThucPhamService().updateThucPham(token, thucPham);
      if (response is Success) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Đã xóa món ${thucPham.ten}")));
        thucPhamChuaDuyets.remove(thucPham);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Lỗi cập nhật thực phẩm")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> Init(BuildContext context) async {
    await loadListThucPhamChuaDuyet(context);
    isInit = true;
    notifyListeners();
  }

  void clear() {
    thucPhamChuaDuyets.clear();
    isInit = false;
  }
}
