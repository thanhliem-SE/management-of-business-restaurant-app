import 'dart:convert';

import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/thuc_pham.dart';

List<DanhMuc> listDanhMucFromJson(String str) =>
    List<DanhMuc>.from(json.decode(str).map((x) => DanhMuc.fromJson(x)));

String listDanhMucToJson(List<DanhMuc> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DanhMuc {
  DanhMuc({
    this.maDanhMuc,
    this.loaiDanhMuc,
    this.createdAt,
    this.updatedAt,
  });

  int? maDanhMuc;
  String? loaiDanhMuc;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ChiTietThucPham>? thucphams;

  factory DanhMuc.fromJson(Map<String, dynamic> json) => DanhMuc(
        maDanhMuc: json["maDanhMuc"],
        loaiDanhMuc: json["loaiDanhMuc"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maDanhMuc": maDanhMuc,
        "loaiDanhMuc": loaiDanhMuc,
      };
}
