import 'package:flutter/cupertino.dart';

class SignUpViewModel extends ChangeNotifier {
  String? tenKhachHang;
  String? soDienthoai;
  String? tenTaikhoan;
  String? matKhau;
  String? nhapLaiMatKhau;
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
    print(tenKhachHang);
  }
}
