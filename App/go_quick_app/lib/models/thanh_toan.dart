class ThanhToan {
  ThanhToan({
    this.maThanhToan,
    this.hinhThucThanhToan,
    this.tienKhachTra,
    this.tienThua,
    this.createdAt,
    this.updatedAt,
  });

  int? maThanhToan;
  String? hinhThucThanhToan;
  double? tienKhachTra;
  double? tienThua;
  DateTime? createdAt;
  DateTime? updatedAt;

  int? get getMaThanhToan => this.maThanhToan;

  set setMaThanhToan(int? maThanhToan) => this.maThanhToan = maThanhToan;

  get getHinhThucThanhToan => this.hinhThucThanhToan;

  set setHinhThucThanhToan(hinhThucThanhToan) =>
      this.hinhThucThanhToan = hinhThucThanhToan;

  get getTienKhachTra => this.tienKhachTra;

  set setTienKhachTra(tienKhachTra) => this.tienKhachTra = tienKhachTra;

  get getTienThua => this.tienThua;

  set setTienThua(tienThua) => this.tienThua = tienThua;

  get getCreatedAt => this.createdAt;

  set setCreatedAt(createdAt) => this.createdAt = createdAt;

  get getUpdatedAt => this.updatedAt;

  set setUpdatedAt(updatedAt) => this.updatedAt = updatedAt;

  factory ThanhToan.fromJson(Map<String, dynamic> json) => ThanhToan(
        maThanhToan: json["maThanhToan"],
        hinhThucThanhToan: json["hinhThucThanhToan"],
        tienKhachTra: json["tienKhachTra"],
        tienThua: json["tienThua"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).add(const Duration(hours: 7))
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"]).add(const Duration(hours: 7))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maThanhToan": maThanhToan,
        "hinhThucThanhToan": hinhThucThanhToan,
        "tienKhachTra": tienKhachTra,
        "tienThua": tienThua,
      };
}
