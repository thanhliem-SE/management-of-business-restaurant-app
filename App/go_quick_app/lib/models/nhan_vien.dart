import 'package:go_quick_app/models/tai_khoan.dart';

class NhanVien {
  NhanVien({
    required this.maNhanVien,
    required this.tenNhanVien,
    required this.soDienThoai,
    required this.createdAt,
    required this.updatedAt,
    required this.taiKhoan,
  });

  int maNhanVien;
  String tenNhanVien;
  String soDienThoai;
  DateTime createdAt;
  DateTime updatedAt;
  TaiKhoan taiKhoan;

  factory NhanVien.fromJson(Map<String, dynamic> json) => NhanVien(
        maNhanVien: json["maNhanVien"],
        tenNhanVien: json["tenNhanVien"],
        soDienThoai: json["soDienThoai"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        taiKhoan: TaiKhoan.fromJson(json["taiKhoan"]),
      );

  Map<String, dynamic> toJson() => {
        "maNhanVien": maNhanVien,
        "tenNhanVien": tenNhanVien,
        "soDienThoai": soDienThoai,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "taiKhoan": taiKhoan.toJson(),
      };
}
