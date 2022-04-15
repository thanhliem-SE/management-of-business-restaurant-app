// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nhan_vien.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NhanVienAdapter extends TypeAdapter<NhanVien> {
  @override
  final int typeId = 1;

  @override
  NhanVien read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NhanVien(
      maNhanVien: fields[0] as int,
      tenNhanVien: fields[1] as String,
      soDienThoai: fields[2] as String,
      createdAt: fields[3] as DateTime,
      updatedAt: fields[4] as DateTime,
      taiKhoan: fields[5] as TaiKhoan,
    );
  }

  @override
  void write(BinaryWriter writer, NhanVien obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.maNhanVien)
      ..writeByte(1)
      ..write(obj.tenNhanVien)
      ..writeByte(2)
      ..write(obj.soDienThoai)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.taiKhoan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NhanVienAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
