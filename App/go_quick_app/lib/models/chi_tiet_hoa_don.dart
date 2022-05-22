// To parse this JSON data, do
//
//     final chiTietHoaDon = chiTietHoaDonFromJson(jsonString);

import 'dart:convert';

import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
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
    this.nguoiCheBien,
    this.soLuong,
    this.khongTiepNhan,
    this.hoaDon,
    this.daCheBien,
    this.daPhucVu,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
  });

  int? maChiTietHoaDon;
  ThucPham? thucPham;
  NhanVien? nguoiCheBien;
  int? soLuong;
  bool? daCheBien;
  bool? daPhucVu;
  bool? khongTiepNhan;
  int? thanhTien;
  HoaDon? hoaDon;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isDeleted;

  factory ChiTietHoaDon.fromJson(Map<String, dynamic> json) => ChiTietHoaDon(
        maChiTietHoaDon: json["maChiTietHoaDon"],
        thucPham: ThucPham.fromJson(json["thucPham"]),
        soLuong: json["soLuong"],
        nguoiCheBien: json["nguoiCheBien"] != null
            ? NhanVien.fromJson(json["nguoiCheBien"])
            : null,
        daCheBien: json["daCheBien"],
        daPhucVu: json["daPhucVu"],
        khongTiepNhan: json["khongTiepNhan"],
        hoaDon: HoaDon.fromJson(json["hoaDon"]),
        isDeleted: json["deleted"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).add(const Duration(hours: 7))
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"]).add(const Duration(hours: 7))
            : null,
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "maChiTietHoaDon": maChiTietHoaDon,
      "thucPham": thucPham?.toJson(),
      "soLuong": soLuong,
      "daCheBien": daCheBien,
      "daPhucVu": daPhucVu,
      "khongTiepNhan": khongTiepNhan ?? false,
      "nguoiCheBien": nguoiCheBien != null ? nguoiCheBien?.toJson() : null,
      "hoaDon": hoaDon?.toJson(),
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
