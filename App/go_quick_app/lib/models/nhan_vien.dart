import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:hive/hive.dart';
part 'nhan_vien.g.dart';

@HiveType(typeId: 1)
class NhanVien {
  NhanVien({
    required this.maNhanVien,
    required this.tenNhanVien,
    required this.soDienThoai,
    required this.createdAt,
    required this.updatedAt,
    required this.taiKhoan,
  });

  @HiveField(0)
  int maNhanVien;

  @HiveField(1)
  String tenNhanVien;

  @HiveField(2)
  String soDienThoai;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime updatedAt;

  @HiveField(5)
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
