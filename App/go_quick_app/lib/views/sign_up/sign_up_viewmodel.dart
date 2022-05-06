import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_quick_app/models/quyen.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/utils/helper.dart';

class SignUpViewModel extends ChangeNotifier {
  String? tenKhachHang;
  String? soDienthoai;
  String? tenTaikhoan;
  String? matKhau;
  String? nhapLaiMatKhau;
  String token = "";
  String get getToken => this.token;

  void setToken(String token) {
    this.token = token;
    Helper.setToken(token);
  }

  bool _loading = false;

  String? get getTenKhachHang => this.tenKhachHang;

  set setTenKhachHang(String tenKhachHang) => this.tenKhachHang = tenKhachHang;

  get getSoDienthoai => this.soDienthoai;

  set setSoDienthoai(soDienthoai) => this.soDienthoai = soDienthoai;

  get getTenTaikhoan => this.tenTaikhoan;

  set setTenTaikhoan(tenTaikhoan) => this.tenTaikhoan = tenTaikhoan;

  get getMatKhau => this.matKhau;

  set setMatKhau(matKhau) => this.matKhau = matKhau;

  get getNhapLaiMatKhau => this.nhapLaiMatKhau;

  set setNhapLaiMatKhau(nhapLaiMatKhau) => this.nhapLaiMatKhau = nhapLaiMatKhau;

  get loading => this._loading;

  setLoading(bool value) {
    this._loading = value;
  }

  SignUp(context) async {
    setLoading(true);
    // khachHang.tenKhachHang = tenKhachHang;
    // khachHang.soDienThoai = soDienthoai;
    // TaiKhoan taikhoan = TaiKhoan();
    // taikhoan.tenTaiKhoan = tenTaikhoan;
    // taikhoan.matKhau = matKhau;
    // taikhoan.quyen = "KHACHHANG";
    // khachHang.taiKhoan = taikhoan;
    // var response = await KhachHangService().dangKyTaiKhoanKhachHang(khachHang);
    // if (response is Success) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("dang ky thanh cong")));
    // }
    // if (response is Failure) {
    //   String errorResponse = (response).errrorResponse as String;
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(errorResponse)));
    // }
  }
}
