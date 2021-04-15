// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 12;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      id: fields[0] as String,
      name: fields[1] as String,
      icon: fields[2] as HabitIcon,
      images: fields[3] as HabitImage,
      isSaveDiary: fields[4] as bool,
      reminds: (fields[5] as List)?.cast<HabitRemind>(),
      motivation: fields[6] as HabitMotivation,
      missionDayUnit: fields[7] as int,
      missionDayCheckInStep: fields[8] as int,
      totalDayAmount: fields[9] as int,
      isFinished: fields[10] as bool,
      habitProgress: (fields[11] as List)?.cast<HabitProgressItem>(),
      type: fields[12] as int,
      frequency: fields[13] as HabitFrequency,
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.images)
      ..writeByte(4)
      ..write(obj.isSaveDiary)
      ..writeByte(5)
      ..write(obj.reminds)
      ..writeByte(6)
      ..write(obj.motivation)
      ..writeByte(7)
      ..write(obj.missionDayUnit)
      ..writeByte(8)
      ..write(obj.missionDayCheckInStep)
      ..writeByte(9)
      ..write(obj.totalDayAmount)
      ..writeByte(10)
      ..write(obj.isFinished)
      ..writeByte(11)
      ..write(obj.habitProgress)
      ..writeByte(12)
      ..write(obj.type)
      ..writeByte(13)
      ..write(obj.frequency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
