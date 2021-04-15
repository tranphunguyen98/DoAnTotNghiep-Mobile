// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_remind.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitRemindAdapter extends TypeAdapter<HabitRemind> {
  @override
  final int typeId = 11;

  @override
  HabitRemind read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitRemind(
      hour: fields[0] as int,
      minute: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HabitRemind obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitRemindAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
