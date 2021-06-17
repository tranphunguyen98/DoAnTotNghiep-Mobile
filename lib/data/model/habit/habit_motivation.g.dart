// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_motivation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitMotivationAdapter extends TypeAdapter<HabitMotivation> {
  @override
  final int typeId = 9;

  @override
  HabitMotivation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitMotivation(
      text: fields[0] as String,
      images: (fields[1] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HabitMotivation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitMotivationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
