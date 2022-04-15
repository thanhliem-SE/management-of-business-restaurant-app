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
    required this.tenTaiKhoan,
    required this.matKhau,
    required this.quyen,
    required this.createdAt,
    required this.updatedAt,
  });

  @HiveField(0)
  String tenTaiKhoan;

  @HiveField(1)
  String matKhau;

  @HiveField(2)
  String quyen;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime updatedAt;

  factory TaiKhoan.fromJson(Map<String, dynamic> json) => TaiKhoan(
        tenTaiKhoan: json["tenTaiKhoan"],
        matKhau: json["matKhau"],
        quyen: json["quyen"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "tenTaiKhoan": tenTaiKhoan,
        "matKhau": matKhau,
        "quyen": quyen,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
