// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_frequency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitFrequencyAdapter extends TypeAdapter<HabitFrequency> {
  @override
  final int typeId = 6;

  @override
  HabitFrequency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitFrequency(
      typeFrequency: fields[0] as int,
      dailyDays: (fields[1] as List)?.cast<int>(),
      weeklyDays: fields[2] as int,
      intervalDays: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HabitFrequency obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.typeFrequency)
      ..writeByte(1)
      ..write(obj.dailyDays)
      ..writeByte(2)
      ..write(obj.weeklyDays)
      ..writeByte(3)
      ..write(obj.intervalDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitFrequencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
