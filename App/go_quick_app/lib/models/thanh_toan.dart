class ThanhToan {
  ThanhToan({
    required this.maThanhToan,
    required this.hinhThucThanhToan,
    required this.tienKhachTra,
    required this.tienThua,
    this.createdAt,
    this.updatedAt,
  });

  int maThanhToan;
  String hinhThucThanhToan;
  double tienKhachTra;
  double tienThua;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ThanhToan.fromJson(Map<String, dynamic> json) => ThanhToan(
        maThanhToan: json["maThanhToan"],
        hinhThucThanhToan: json["hinhThucThanhToan"],
        tienKhachTra: json["tienKhachTra"],
        tienThua: json["tienThua"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maThanhToan": maThanhToan,
        "hinhThucThanhToan": hinhThucThanhToan,
        "tienKhachTra": tienKhachTra,
        "tienThua": tienThua,
      };
}
