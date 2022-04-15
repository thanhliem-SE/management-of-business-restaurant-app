// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tai_khoan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaiKhoanAdapter extends TypeAdapter<TaiKhoan> {
  @override
  final int typeId = 0;

  @override
  TaiKhoan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaiKhoan(
      tenTaiKhoan: fields[0] as String,
      matKhau: fields[1] as String,
      quyen: fields[2] as String,
      createdAt: fields[3] as DateTime,
      updatedAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TaiKhoan obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tenTaiKhoan)
      ..writeByte(1)
      ..write(obj.matKhau)
      ..writeByte(2)
      ..write(obj.quyen)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaiKhoanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
