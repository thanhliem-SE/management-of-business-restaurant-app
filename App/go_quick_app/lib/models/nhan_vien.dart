import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:hive/hive.dart';
part 'nhan_vien.g.dart';

@HiveType(typeId: 1)
class NhanVien {
  NhanVien({
    this.maNhanVien,
    this.tenNhanVien,
    this.soDienThoai,
    this.taiKhoan,
    this.createdAt,
    this.updatedAt,
  });

  @HiveField(0)
  int? maNhanVien;

  @HiveField(1)
  String? tenNhanVien;

  @HiveField(2)
  String? soDienThoai;

  @HiveField(3)
  DateTime? createdAt;

  @HiveField(4)
  DateTime? updatedAt;

  @HiveField(5)
  TaiKhoan? taiKhoan;

  factory NhanVien.fromJson(Map<String, dynamic> json) => NhanVien(
        maNhanVien: json["maNhanVien"],
        tenNhanVien: json["tenNhanVien"],
        soDienThoai: json["soDienThoai"],
        taiKhoan: TaiKhoan.fromJson(json["taiKhoan"]),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maNhanVien": maNhanVien,
        "tenNhanVien": tenNhanVien,
        "soDienThoai": soDienThoai,
        "taiKhoan": taiKhoan?.toJson(),
      };
}
