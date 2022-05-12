// To parse this JSON data, do
//
//     final thongBao = thongBaoFromJson(jsonString);

import 'dart:convert';

import 'package:go_quick_app/models/tai_khoan.dart';

List<ThongBao> listThongBaoFromJson(String str) =>
    List<ThongBao>.from(json.decode(str).map((x) => ThongBao.fromJson(x)));

String listThongBaoToJson(List<ThongBao> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ThongBao {
  ThongBao({
    this.maThongBao,
    this.noiDung,
    this.daXem,
    this.taiKhoan,
    this.createdAt,
    this.updatedAt,
  });

  int? maThongBao;
  String? noiDung;
  bool? daXem;
  TaiKhoan? taiKhoan;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ThongBao.fromJson(Map<String, dynamic> json) => ThongBao(
        maThongBao: json["maThongBao"],
        noiDung: json["noiDung"],
        daXem: json["daXem"],
        taiKhoan: TaiKhoan.fromJson(json["taiKhoan"]),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maThongBao": maThongBao,
        "noiDung": noiDung,
        "daXem": daXem,
        "taiKhoan": taiKhoan!.toJson(),
      };
}
