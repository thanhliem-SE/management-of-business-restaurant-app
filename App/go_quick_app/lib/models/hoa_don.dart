// To parse this JSON data, do
//
//     final hoaDon = hoaDonFromJson(jsonString);

import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
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
    this.ban,
    this.ghiChu,
    this.daTraHoaDon,
    this.tinhTrang,
    this.createdAt,
    this.updatedAt,
  });

  int? maHoaDon;
  NhanVien? nguoiLapHoaDon;
  double? tongThanhTien;
  ThanhToan? thanhToan;
  Ban? ban;
  String? ghiChu;
  bool? daTraHoaDon;
  String? tinhTrang;
  List<ChiTietHoaDon>? chiTietHoaDons;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HoaDon.fromJson(Map<String, dynamic> json) => HoaDon(
        maHoaDon: json["maHoaDon"],
        nguoiLapHoaDon: NhanVien.fromJson(json["nguoiLapHoaDon"]),
        tongThanhTien: json["tongThanhTien"],
        thanhToan: json["thanhToan"] != null
            ? ThanhToan.fromJson(json["thanhToan"])
            : null,
        ban: Ban.fromJson(json["ban"]),
        daTraHoaDon: json["daTraHoaDon"],
        tinhTrang: json["tinhTrang"],
        ghiChu: json["ghiChu"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).add(const Duration(hours: 7))
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"]).add(const Duration(hours: 7))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maHoaDon": maHoaDon,
        "nguoiLapHoaDon": nguoiLapHoaDon?.toJson(),
        // ignore: prefer_null_aware_operators
        "tongThanhTien": tongThanhTien,
        "thanhToan": thanhToan?.toJson(),
        "ghiChu": ghiChu,
        "ban": ban?.toJson(),
        "tinhTrang": tinhTrang,
        "daTraHoaDon": daTraHoaDon
      };
}
