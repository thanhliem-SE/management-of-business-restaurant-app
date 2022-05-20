import 'package:flutter/material.dart';
import 'package:go_quick_app/models/nhan_vien.dart';

import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/nhan_vien_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';

import 'manage_account_view.dart';

class ManageAccountViewModel extends ChangeNotifier {
  bool initialized = false;
  List<QuyenVaTaiKhoan> quyenList = <QuyenVaTaiKhoan>[];

  Initialied(BuildContext context) async {
    quyenList
      ..add(new QuyenVaTaiKhoan(quyen: "QUANLY", nhanViens: []))
      ..add(new QuyenVaTaiKhoan(quyen: "PHUCVU", nhanViens: []))
      ..add(new QuyenVaTaiKhoan(quyen: "CHEBIEN", nhanViens: []))
      ..add(new QuyenVaTaiKhoan(quyen: "THUNGAN", nhanViens: []));
    await loadNhanVienIntoQuyen(context);
    initialized = true;
    notifyListeners();
  }

  Future<void> loadNhanVienIntoQuyen(BuildContext context) async {
    try {
      String token = await Helper.getToken();

      for (var i = 0; i < quyenList.length; i++) {
        var response = await NhanVienService()
            .getNhanVienTheoQuyen(token, quyenList[i].quyen);
        if (response is Success) {
          quyenList[i].nhanViens = response.response as List<NhanVien>;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Lấy nhân viên không thành công cho quyền ${quyenList[i].quyen}")));
        }
        if (i == quyenList.length - 1) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Hoàn tất tải nhân viên")));
          notifyListeners();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> createNhanVien(BuildContext context, NhanVien nhanVien) async {
    try {
      String token = await Helper.getToken();
      var response = await NhanVienService().createNhanVien(token, nhanVien);
      if (response is Success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Thêm thành công")));
        NavigationHelper.pushReplacement(
            context: context, page: const ManageAccountView());
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Thêm không thành công")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> xoaNhanVien(BuildContext context, NhanVien nhanVien) async {
    try {
      String token = await Helper.getToken();
      nhanVien.isDeleted = true;
      var response = await NhanVienService().updateNhanVien(token, nhanVien);
      if (response is Success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Xóa tài khoản ${nhanVien.tenNhanVien} thành công")));
        await loadNhanVienIntoQuyen(context);
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Xóa tài khoản ${nhanVien.tenNhanVien} thất bại")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  void clear() {
    quyenList.clear();
    initialized = false;
  }
}

class QuyenVaTaiKhoan {
  String quyen;
  List<NhanVien> nhanViens;
  QuyenVaTaiKhoan({
    required this.quyen,
    required this.nhanViens,
  });
}
