// To parse this JSON data, do
//
//     final thongKeMonAn = thongKeMonAnFromJson(jsonString);

import 'dart:convert';

List<ThongKeMonAn> listThongKeMonAnFromJson(String str) =>
    List<ThongKeMonAn>.from(
        json.decode(str).map((x) => ThongKeMonAn.fromJson(x)));

String listThongKeMonAnToJson(List<ThongKeMonAn> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ThongKeMonAn {
  ThongKeMonAn({
    this.maThucPham,
    this.tongSoLuong,
  });

  int? maThucPham;
  int? tongSoLuong;

  factory ThongKeMonAn.fromJson(Map<String, dynamic> json) => ThongKeMonAn(
        maThucPham: json["maThucPham"],
        tongSoLuong: json["tongSoLuong"],
      );

  Map<String, dynamic> toJson() => {
        "maThucPham": maThucPham,
        "tongSoLuong": tongSoLuong,
      };
}
