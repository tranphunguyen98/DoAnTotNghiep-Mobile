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
      motivation: fields[6] as HabitMotivation,
      missionDayUnit: fields[7] as int,
      missionDayCheckInStep: fields[8] as int,
      totalDayAmount: fields[9] as int,
      typeHabitMissionDayCheckIn: fields[14] as int,
      typeHabitGoal: fields[15] as int,
      isFinished: fields[10] as bool,
      isTrashed: fields[17] as bool,
      type: fields[12] as int,
      createdAt: fields[16] as String,
      updatedAt: fields[18] as String,
      reminds: (fields[5] as List)?.cast<HabitRemind>(),
      frequency: fields[13] as HabitFrequency,
      habitProgress: (fields[11] as List)?.cast<HabitProgressItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(19)
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
      ..write(obj.frequency)
      ..writeByte(14)
      ..write(obj.typeHabitMissionDayCheckIn)
      ..writeByte(15)
      ..write(obj.typeHabitGoal)
      ..writeByte(16)
      ..write(obj.createdAt)
      ..writeByte(17)
      ..write(obj.isTrashed)
      ..writeByte(18)
      ..write(obj.updatedAt);
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
