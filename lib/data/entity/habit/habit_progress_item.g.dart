// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_progress_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitProgressItemAdapter extends TypeAdapter<HabitProgressItem> {
  @override
  final int typeId = 10;

  @override
  HabitProgressItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitProgressItem(
      diaries: (fields[0] as List)?.cast<DiaryItem>(),
      currentCheckInAmounts: fields[1] as int,
      isDone: fields[2] as bool,
      day: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HabitProgressItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.diaries)
      ..writeByte(1)
      ..write(obj.currentCheckInAmounts)
      ..writeByte(2)
      ..write(obj.isDone)
      ..writeByte(3)
      ..write(obj.day);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitProgressItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
