import 'dart:convert';

import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:hive/hive.dart';
part 'nhan_vien.g.dart';

List<NhanVien> listNhanVienFromJson(String str) =>
    List<NhanVien>.from(json.decode(str).map((x) => NhanVien.fromJson(x)));

String listNhanVienToJson(List<NhanVien> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class NhanVien {
  NhanVien({
    this.maNhanVien,
    this.tenNhanVien,
    this.soDienThoai,
    this.taiKhoan,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
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

  bool? isDeleted;

  factory NhanVien.fromJson(Map<String, dynamic> json) => NhanVien(
        maNhanVien: json["maNhanVien"],
        tenNhanVien: json["tenNhanVien"],
        soDienThoai: json["soDienThoai"],
        isDeleted: json["deleted"],
        taiKhoan: TaiKhoan.fromJson(json["taiKhoan"]),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).add(const Duration(hours: 7))
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"]).add(const Duration(hours: 7))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maNhanVien": maNhanVien,
        "tenNhanVien": tenNhanVien,
        "soDienThoai": soDienThoai,
        "deleted": isDeleted,
        "taiKhoan": taiKhoan?.toJson(),
      };
}
