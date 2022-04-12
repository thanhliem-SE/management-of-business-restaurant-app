class ThucPham {
  ThucPham({
    required this.maThucPham,
    required this.ten,
    required this.moTa,
    required this.giaTien,
    required this.urlHinhAnh,
    required this.chiTiet,
    required this.trangThai,
    required this.createdAt,
    required this.updatedAt,
  });

  int maThucPham;
  String ten;
  String moTa;
  double giaTien;
  List<String> urlHinhAnh;
  String chiTiet;
  String trangThai;
  DateTime createdAt;
  DateTime updatedAt;

  factory ThucPham.fromJson(Map<String, dynamic> json) => ThucPham(
        maThucPham: json["maThucPham"],
        ten: json["ten"],
        moTa: json["moTa"],
        giaTien: json["giaTien"],
        urlHinhAnh: List<String>.from(json["urlHinhAnh"].map((x) => x)),
        chiTiet: json["chiTiet"],
        trangThai: json["trangThai"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "maThucPham": maThucPham,
        "ten": ten,
        "moTa": moTa,
        "giaTien": giaTien,
        "urlHinhAnh": List<dynamic>.from(urlHinhAnh.map((x) => x)),
        "chiTiet": chiTiet,
        "trangThai": trangThai,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
