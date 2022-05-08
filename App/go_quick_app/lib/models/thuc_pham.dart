import 'dart:convert';

import 'package:go_quick_app/models/danh_muc.dart';

List<ThucPham> listThucPhamFromJson(String str) =>
    List<ThucPham>.from(json.decode(str).map((x) => ThucPham.fromJson(x)));

String listThucPhamToJson(List<ThucPham> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ThucPham {
  ThucPham({
    this.maThucPham,
    this.ten,
    this.moTa,
    this.giaTien,
    this.urlHinhAnh,
    this.chiTiet,
    this.trangThai,
    this.danhMuc,
    this.createdAt,
    this.updatedAt,
  });

  int? maThucPham;
  String? ten;
  String? moTa;
  double? giaTien;
  List<String>? urlHinhAnh;
  DanhMuc? danhMuc;

  String? chiTiet;
  String? trangThai;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ThucPham.fromJson(Map<String, dynamic> json) => ThucPham(
        maThucPham: json["maThucPham"],
        ten: json["ten"],
        moTa: json["moTa"],
        giaTien: json["giaTien"],
        urlHinhAnh: List<String>.from(json["urlHinhAnh"].map((x) => x)),
        chiTiet: json["chiTiet"],
        danhMuc: DanhMuc.fromJson(json["danhMuc"]),
        trangThai: json["trangThai"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maThucPham": maThucPham,
        "ten": ten,
        "moTa": moTa,
        "giaTien": giaTien,
        "urlHinhAnh": List<dynamic>.from(urlHinhAnh!.map((x) => x)),
        "chiTiet": chiTiet,
        "trangThai": trangThai,
        "danhMuc": danhMuc?.toJson(),
      };
}
