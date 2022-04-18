class DiaChi {
  DiaChi({
    this.soNha,
    this.phuong,
    this.quan,
    this.tinh,
  });

  String? soNha;
  String? phuong;
  String? quan;
  String? tinh;

  factory DiaChi.fromJson(Map<String, dynamic> json) => DiaChi(
        soNha: json["soNha"],
        phuong: json["phuong"],
        quan: json["quan"],
        tinh: json["tinh"],
      );

  Map<String, dynamic> toJson() => {
        "soNha": soNha,
        "phuong": phuong,
        "quan": quan,
        "tinh": tinh,
      };
}
