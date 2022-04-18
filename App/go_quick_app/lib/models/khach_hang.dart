import 'package:go_quick_app/models/dia_chi.dart';
import 'package:go_quick_app/models/tai_khoan.dart';

class KhachHang {
  KhachHang({
    this.maKhachHang,
    this.tenKhachHang,
    this.diaChiNhanHang,
    this.taiKhoan,
    this.soDienThoai,
    this.createdAt,
    this.updatedAt,
  });

  int? maKhachHang;
  String? tenKhachHang;
  DiaChi? diaChiNhanHang;
  TaiKhoan? taiKhoan;
  String? soDienThoai;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory KhachHang.fromJson(Map<String, dynamic> json) => KhachHang(
        maKhachHang: json["maKhachHang"],
        tenKhachHang: json["tenKhachHang"],
        diaChiNhanHang: DiaChi.fromJson(json["diaChiNhanHang"]),
        taiKhoan: TaiKhoan.fromJson(json["taiKhoan"]),
        soDienThoai: json["soDienThoai"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maKhachHang": maKhachHang,
        "tenKhachHang": tenKhachHang,
        "diaChiNhanHang": diaChiNhanHang?.toJson(),
        "taiKhoan": taiKhoan?.toJson(),
        "soDienThoai": soDienThoai,
      };
}
