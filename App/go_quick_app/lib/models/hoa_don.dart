// To parse this JSON data, do
//
//     final hoaDon = hoaDonFromJson(jsonString);

import 'package:go_quick_app/models/khach_hang.dart';
import 'package:go_quick_app/models/nguoi_lap_hoa_don.dart';
import 'package:go_quick_app/models/thanh_toan.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<HoaDon> listHoaDonFromJson(String str) =>
    List<HoaDon>.from(json.decode(str).map((x) => HoaDon.fromJson(x)));

String listHoaDonToJson(List<HoaDon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HoaDon {
  HoaDon({
    required this.maHoaDon,
    required this.nguoiLapHoaDon,
    required this.khachHang,
    required this.tongThanhTien,
    required this.thanhToan,
    required this.ban,
    required this.soNguoi,
    required this.tinhTrang,
    required this.createdAt,
    required this.updatedAt,
  });

  int maHoaDon;
  NguoiLapHoaDon nguoiLapHoaDon;
  KhachHang khachHang;
  double tongThanhTien;
  ThanhToan thanhToan;
  int ban;
  int soNguoi;
  String tinhTrang;
  DateTime createdAt;
  DateTime updatedAt;

  factory HoaDon.fromJson(Map<String, dynamic> json) => HoaDon(
        maHoaDon: json["maHoaDon"],
        nguoiLapHoaDon: NguoiLapHoaDon.fromJson(json["nguoiLapHoaDon"]),
        khachHang: KhachHang.fromJson(json["khachHang"]),
        tongThanhTien: json["tongThanhTien"],
        thanhToan: ThanhToan.fromJson(json["thanhToan"]),
        ban: json["ban"],
        soNguoi: json["soNguoi"],
        tinhTrang: json["tinhTrang"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "maHoaDon": maHoaDon,
        "nguoiLapHoaDon": nguoiLapHoaDon.toJson(),
        "khachHang": khachHang.toJson(),
        "tongThanhTien": tongThanhTien,
        "thanhToan": thanhToan.toJson(),
        "ban": ban,
        "soNguoi": soNguoi,
        "tinhTrang": tinhTrang,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
