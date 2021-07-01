// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryAdapter extends TypeAdapter<Diary> {
  @override
  final int typeId = 5;

  @override
  Diary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Diary(
      text: fields[0] as String,
      images: (fields[1] as List)?.cast<String>(),
      id: fields[2] as String,
      feeling: fields[3] as int,
      time: fields[4] as String,
      habit: fields[5] as String,
      createdAt: fields[6] as String,
      updatedAt: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Diary obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.images)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.feeling)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.habit)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
