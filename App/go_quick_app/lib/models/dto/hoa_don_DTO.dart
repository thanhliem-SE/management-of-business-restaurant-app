// To parse this JSON data, do
//
//     final hoaDonDto = hoaDonDtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HoaDonDTO hoaDonDTOFromJson(String str) => HoaDonDTO.fromJson(json.decode(str));

String hoaDonDTOToJson(HoaDonDTO data) => json.encode(data.toJson());

class HoaDonDTO {
  HoaDonDTO({
    required this.nguoiLapHoaDon,
    required this.tongThanhTien,
    required this.ban,
    required this.soNguoi,
    required this.tinhTrang,
    required this.thanhToan,
    required this.khachHang,
  });

  NguoiLapHoaDon nguoiLapHoaDon;
  KhachHang khachHang = KhachHang(maKhachHang: 1);
  int tongThanhTien;
  int ban;
  int soNguoi;
  String tinhTrang;
  ThanhToan thanhToan;

  factory HoaDonDTO.fromJson(Map<String, dynamic> json) => HoaDonDTO(
        nguoiLapHoaDon: NguoiLapHoaDon.fromJson(json["nguoiLapHoaDon"]),
        khachHang: KhachHang.fromJson(json["khachHang"]),
        tongThanhTien: json["tongThanhTien"],
        ban: json["ban"],
        soNguoi: json["soNguoi"],
        tinhTrang: json["tinhTrang"],
        thanhToan: ThanhToan.fromJson(json["thanhToan"]),
      );

  Map<String, dynamic> toJson() => {
        "nguoiLapHoaDon": nguoiLapHoaDon.toJson(),
        "khachHang": khachHang.toJson(),
        "tongThanhTien": tongThanhTien,
        "ban": ban,
        "soNguoi": soNguoi,
        "tinhTrang": tinhTrang,
        "thanhToan": thanhToan.toJson(),
      };
}

class KhachHang {
  KhachHang({
    required this.maKhachHang,
  });

  int maKhachHang;

  factory KhachHang.fromJson(Map<String, dynamic> json) => KhachHang(
        maKhachHang: json["maKhachHang"],
      );

  Map<String, dynamic> toJson() => {
        "maKhachHang": maKhachHang,
      };
}

class NguoiLapHoaDon {
  NguoiLapHoaDon({
    required this.maNhanVien,
  });

  int maNhanVien;

  factory NguoiLapHoaDon.fromJson(Map<String, dynamic> json) => NguoiLapHoaDon(
        maNhanVien: json["maNhanVien"],
      );

  Map<String, dynamic> toJson() => {
        "maNhanVien": maNhanVien,
      };
}

class ThanhToan {
  ThanhToan({
    required this.maThanhToan,
  });

  int maThanhToan;

  factory ThanhToan.fromJson(Map<String, dynamic> json) => ThanhToan(
        maThanhToan: json["maThanhToan"],
      );

  Map<String, dynamic> toJson() => {
        "maThanhToan": maThanhToan,
      };
}
