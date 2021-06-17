// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitImageAdapter extends TypeAdapter<HabitImage> {
  @override
  final int typeId = 8;

  @override
  HabitImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitImage(
      imgBg: fields[0] as String,
      imgUnCheckIn: fields[1] as String,
      imgCheckIn: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HabitImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imgBg)
      ..writeByte(1)
      ..write(obj.imgUnCheckIn)
      ..writeByte(2)
      ..write(obj.imgCheckIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
