class Ban {
  Ban({
    this.maSoBan,
    this.viTri,
    this.tinhTrang,
    this.createdAt,
    this.updatedAt,
  });

  int? maSoBan;
  int? viTri;
  String? tinhTrang;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Ban.fromJson(Map<String, dynamic> json) => Ban(
        maSoBan: json["maSoBan"],
        viTri: json["viTri"],
        tinhTrang: json["tinhTrang"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "maSoBan": maSoBan,
        "viTri": viTri,
        "tinhTrang": tinhTrang,
      };
}
