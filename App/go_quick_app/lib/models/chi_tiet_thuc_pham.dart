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
    required this.maChiTietThucPham,
    required this.thucPham,
    required this.soLuong,
    required this.createdAt,
    required this.updatedAt,
  });

  int maChiTietThucPham;
  ThucPham thucPham;
  int soLuong;
  DateTime createdAt;
  DateTime updatedAt;

  factory ChiTietThucPham.fromJson(Map<String, dynamic> json) =>
      ChiTietThucPham(
        maChiTietThucPham: json["maChiTietThucPham"],
        thucPham: ThucPham.fromJson(json["thucPham"]),
        soLuong: json["soLuong"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "maChiTietThucPham": maChiTietThucPham,
        "thucPham": thucPham.toJson(),
        "soLuong": soLuong,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
