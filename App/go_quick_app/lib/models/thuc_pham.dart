class ThucPham {
  ThucPham({
    this.maThucPham,
    this.ten,
    this.moTa,
    this.giaTien,
    this.urlHinhAnh,
    this.chiTiet,
    this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  int? maThucPham;
  String? ten;
  String? moTa;
  double? giaTien;
  List<String>? urlHinhAnh;
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
      };
}
