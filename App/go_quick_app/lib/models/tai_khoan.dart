import 'package:meta/meta.dart';
import 'dart:convert';

List<TaiKhoan> taiKhoanFromJson(String str) =>
    List<TaiKhoan>.from(json.decode(str).map((x) => TaiKhoan.fromJson(x)));

String taiKhoanToJson(List<TaiKhoan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaiKhoan {
  TaiKhoan({
    required this.tenTaiKhoan,
    required this.matKhau,
    required this.quyen,
    required this.createdAt,
    required this.updatedAt,
  });

  String tenTaiKhoan;
  String matKhau;
  String quyen;
  DateTime createdAt;
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
