// To parse this JSON data, do
//
//     final hoaDon = hoaDonFromJson(jsonString);

import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/thanh_toan.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<HoaDon> listHoaDonFromJson(String str) =>
    List<HoaDon>.from(json.decode(str).map((x) => HoaDon.fromJson(x)));

String listHoaDonToJson(List<HoaDon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HoaDon {
  HoaDon({
    this.maHoaDon,
    this.nguoiLapHoaDon,
    this.nguoiCheBien,
    this.tongThanhTien,
    this.thanhToan,
    this.ban,
    this.ghiChu,
    this.tinhTrang,
    this.createdAt,
    this.updatedAt,
  });

  int? maHoaDon;
  NhanVien? nguoiLapHoaDon;
  NhanVien? nguoiCheBien;
  double? tongThanhTien;
  ThanhToan? thanhToan;
  Ban? ban;
  String? ghiChu;
  String? tinhTrang;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HoaDon.fromJson(Map<String, dynamic> json) => HoaDon(
        maHoaDon: json["maHoaDon"],
        nguoiLapHoaDon: NhanVien.fromJson(json["nguoiLapHoaDon"]),
        nguoiCheBien: json["nguoiCheBien"] != null
            ? NhanVien.fromJson(json["nguoiCheBien"])
            : null,
        tongThanhTien: json["tongThanhTien"],
        thanhToan: json["thanhToan"] != null
            ? ThanhToan.fromJson(json["thanhToan"])
            : null,
        ban: Ban.fromJson(json["ban"]),
        tinhTrang: json["tinhTrang"],
        ghiChu: json["ghiChu"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maHoaDon": maHoaDon,
        "nguoiLapHoaDon": nguoiLapHoaDon?.toJson(),
        // ignore: prefer_null_aware_operators
        "nguoiCheBien": nguoiCheBien != null ? nguoiCheBien?.toJson() : null,
        "tongThanhTien": tongThanhTien,
        "thanhToan": thanhToan?.toJson(),
        "ghiChu": ghiChu,
        "ban": ban?.toJson(),
        "tinhTrang": tinhTrang,
      };
}
