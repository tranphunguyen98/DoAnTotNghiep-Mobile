// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_icon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitIconAdapter extends TypeAdapter<HabitIcon> {
  @override
  final int typeId = 7;

  @override
  HabitIcon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitIcon(
      iconColor: fields[0] as String,
      iconText: fields[1] as String,
      iconImage: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HabitIcon obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.iconColor)
      ..writeByte(1)
      ..write(obj.iconText)
      ..writeByte(2)
      ..write(obj.iconImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitIconAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
