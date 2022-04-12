class ThanhToan {
  ThanhToan({
    required this.maThanhToan,
    required this.hinhThucThanhToan,
    required this.tienKhachTra,
    required this.tienThua,
    required this.createdAt,
    required this.updatedAt,
  });

  int maThanhToan;
  String hinhThucThanhToan;
  double tienKhachTra;
  double tienThua;
  DateTime createdAt;
  DateTime updatedAt;

  factory ThanhToan.fromJson(Map<String, dynamic> json) => ThanhToan(
        maThanhToan: json["maThanhToan"],
        hinhThucThanhToan: json["hinhThucThanhToan"],
        tienKhachTra: json["tienKhachTra"],
        tienThua: json["tienThua"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "maThanhToan": maThanhToan,
        "hinhThucThanhToan": hinhThucThanhToan,
        "tienKhachTra": tienKhachTra,
        "tienThua": tienThua,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
