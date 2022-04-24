// To parse this JSON data, do
//
//     final hoaDon = hoaDonFromJson(jsonString);

import 'package:go_quick_app/models/khach_hang.dart';
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
    this.nguoiLapHoaDon,
    this.khachHang,
    this.tongThanhTien,
    this.thanhToan,
    this.ban,
    this.soNguoi,
    this.tinhTrang,
    this.maHoaDon,
    this.createdAt,
    this.updatedAt,
  });

  int? maHoaDon;
  NhanVien? nguoiLapHoaDon;
  KhachHang? khachHang;
  double? tongThanhTien;
  ThanhToan? thanhToan;
  int? ban;
  int? soNguoi;
  String? tinhTrang;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HoaDon.fromJson(Map<String, dynamic> json) => HoaDon(
        maHoaDon: json["maHoaDon"],
        nguoiLapHoaDon: NhanVien.fromJson(json["nguoiLapHoaDon"]),
        khachHang: json["khachHang"] != null
            ? KhachHang.fromJson(json["khachHang"])
            : null,
        tongThanhTien: json["tongThanhTien"],
        thanhToan: json["thanhToan"] != null
            ? ThanhToan.fromJson(json["thanhToan"])
            : null,
        ban: json["ban"],
        soNguoi: json["soNguoi"],
        tinhTrang: json["tinhTrang"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() {
    var json = {
      "maHoaDon": maHoaDon,
      "nguoiLapHoaDon": nguoiLapHoaDon!.toJson(),
      "khachHang": khachHang?.toJson(),
      "tongThanhTien": tongThanhTien,
      "thanhToan": thanhToan?.toJson(),
      "ban": ban,
      "soNguoi": soNguoi,
      "tinhTrang": tinhTrang,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
