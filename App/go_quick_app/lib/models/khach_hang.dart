import 'package:go_quick_app/models/dia_chi.dart';
import 'package:go_quick_app/models/tai_khoan.dart';

class KhachHang {
  KhachHang({
    required this.maKhachHang,
    required this.tenKhachHang,
    required this.diaChiNhanHang,
    required this.taiKhoan,
    required this.soDienThoai,
    required this.createdAt,
    required this.updatedAt,
  });

  int maKhachHang;
  String tenKhachHang;
  DiaChi diaChiNhanHang;
  TaiKhoan taiKhoan;
  String soDienThoai;
  DateTime createdAt;
  DateTime updatedAt;

  factory KhachHang.fromJson(Map<String, dynamic> json) => KhachHang(
        maKhachHang: json["maKhachHang"],
        tenKhachHang: json["tenKhachHang"],
        diaChiNhanHang: DiaChi.fromJson(json["diaChiNhanHang"]),
        taiKhoan: TaiKhoan.fromJson(json["taiKhoan"]),
        soDienThoai: json["soDienThoai"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "maKhachHang": maKhachHang,
        "tenKhachHang": tenKhachHang,
        "diaChiNhanHang": diaChiNhanHang.toJson(),
        "taiKhoan": taiKhoan.toJson(),
        "soDienThoai": soDienThoai,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}