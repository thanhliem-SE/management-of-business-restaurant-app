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
    required this.nguoiLapHoaDon,
    required this.khachHang,
    required this.tongThanhTien,
    required this.thanhToan,
    required this.ban,
    required this.soNguoi,
    required this.tinhTrang,
    this.maHoaDon,
    this.createdAt,
    this.updatedAt,
  });

  NhanVien nguoiLapHoaDon;
  KhachHang khachHang;
  double tongThanhTien;
  ThanhToan thanhToan;
  int ban;
  int soNguoi;
  String tinhTrang;

  int? maHoaDon;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HoaDon.fromJson(Map<String, dynamic> json) => HoaDon(
        maHoaDon: json["maHoaDon"],
        nguoiLapHoaDon: NhanVien.fromJson(json["nguoiLapHoaDon"]),
        khachHang: KhachHang.fromJson(json["khachHang"]),
        tongThanhTien: json["tongThanhTien"],
        thanhToan: ThanhToan.fromJson(json["thanhToan"]),
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

  Map<String, dynamic> toJson() => {
        "nguoiLapHoaDon": nguoiLapHoaDon.toJson(),
        "khachHang": khachHang.toJson(),
        "tongThanhTien": tongThanhTien,
        "thanhToan": thanhToan.toJson(),
        "ban": ban,
        "soNguoi": soNguoi,
        "tinhTrang": tinhTrang,
      };
}
