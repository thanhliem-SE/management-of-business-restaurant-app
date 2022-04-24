// To parse this JSON data, do
//
//     final chiTietHoaDon = chiTietHoaDonFromJson(jsonString);

import 'dart:convert';

import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/models/thuc_pham.dart';

List<ChiTietHoaDon> listChiTietHoaDonFromJson(String str) =>
    List<ChiTietHoaDon>.from(
        json.decode(str).map((x) => ChiTietHoaDon.fromJson(x)));

String listChiTietHoaDonToJson(List<ChiTietHoaDon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChiTietHoaDon {
  ChiTietHoaDon({
    this.maChiTietHoaDon,
    this.thucPham,
    this.soLuong,
    this.thanhTien,
    this.hoaDon,
    this.createdAt,
    this.updatedAt,
  });

  int? maChiTietHoaDon;
  ThucPham? thucPham;
  int? soLuong;
  int? thanhTien;
  HoaDon? hoaDon;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ChiTietHoaDon.fromJson(Map<String, dynamic> json) => ChiTietHoaDon(
        maChiTietHoaDon: json["maChiTietHoaDon"],
        thucPham: ThucPham.fromJson(json["thucPham"]),
        soLuong: json["soLuong"],
        thanhTien: json["thanhTien"],
        hoaDon: HoaDon.fromJson(json["hoaDon"]),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "maChiTietHoaDon": maChiTietHoaDon,
      "thucPham": thucPham?.toJson(),
      "soLuong": soLuong,
      "thanhTien": thanhTien,
      "hoaDon": hoaDon?.toJson(),
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
