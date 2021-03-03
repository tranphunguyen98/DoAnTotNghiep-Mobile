// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckItemAdapter extends TypeAdapter<CheckItem> {
  @override
  final int typeId = 8;

  @override
  CheckItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckItem(
      id: fields[0] as String,
      name: fields[1] as String,
      isCheck: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CheckItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isCheck);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
