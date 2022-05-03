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
    this.tongThanhTien,
    this.thanhToan,
    this.soNguoi,
    this.ban,
    this.tinhTrang,
    this.createdAt,
    this.updatedAt,
  });

  int? maHoaDon;
  NhanVien? nguoiLapHoaDon;
  int? tongThanhTien;
  ThanhToan? thanhToan;
  int? soNguoi;
  Ban? ban;
  String? tinhTrang;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HoaDon.fromJson(Map<String, dynamic> json) => HoaDon(
        maHoaDon: json["maHoaDon"],
        nguoiLapHoaDon: NhanVien.fromJson(json["nguoiLapHoaDon"]),
        tongThanhTien: json["tongThanhTien"],
        thanhToan: ThanhToan.fromJson(json["thanhToan"]),
        soNguoi: json["soNguoi"],
        ban: Ban.fromJson(json["ban"]),
        tinhTrang: json["tinhTrang"],
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
        "tongThanhTien": tongThanhTien,
        "thanhToan": thanhToan?.toJson(),
        "soNguoi": soNguoi,
        "ban": ban?.toJson(),
        "tinhTrang": tinhTrang,
      };
}
