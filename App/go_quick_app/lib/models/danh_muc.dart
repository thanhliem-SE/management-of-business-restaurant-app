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
