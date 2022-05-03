// To parse this JSON data, do
//
//     final chiTietThucPham = chiTietThucPhamFromJson(jsonString);

import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<ChiTietThucPham> listChiTietThucPhamFromJson(String str) =>
    List<ChiTietThucPham>.from(
        json.decode(str).map((x) => ChiTietThucPham.fromJson(x)));

String listChiTietThucPhamToJson(List<ChiTietThucPham> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChiTietThucPham {
  ChiTietThucPham({
    this.maChiTietThucPham,
    this.thucPham,
    this.soLuong,
    this.createdAt,
    this.updatedAt,
  });

  int? maChiTietThucPham;
  ThucPham? thucPham;
  int? soLuong;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ChiTietThucPham.fromJson(Map<String, dynamic> json) =>
      ChiTietThucPham(
        maChiTietThucPham: json["maChiTietThucPham"],
        thucPham: ThucPham.fromJson(json["thucPham"]),
        soLuong: json["soLuong"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maChiTietThucPham": maChiTietThucPham,
        "thucPham": thucPham?.toJson(),
        "soLuong": soLuong,
      };
}
