import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part 'tai_khoan.g.dart';

List<TaiKhoan> taiKhoanFromJson(String str) =>
    List<TaiKhoan>.from(json.decode(str).map((x) => TaiKhoan.fromJson(x)));

String taiKhoanToJson(List<TaiKhoan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class TaiKhoan {
  TaiKhoan({
    this.tenTaiKhoan,
    this.matKhau,
    this.quyen,
    this.createdAt,
    this.updatedAt,
  });

  @HiveField(0)
  String? tenTaiKhoan;

  @HiveField(1)
  String? matKhau;

  @HiveField(2)
  String? quyen;

  @HiveField(3)
  DateTime? createdAt;

  @HiveField(4)
  DateTime? updatedAt;

  factory TaiKhoan.fromJson(Map<String, dynamic> json) => TaiKhoan(
        tenTaiKhoan: json["tenTaiKhoan"],
        matKhau: json["matKhau"],
        quyen: json["quyen"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "tenTaiKhoan": tenTaiKhoan,
        "matKhau": matKhau,
        "quyen": quyen,
      };
}
