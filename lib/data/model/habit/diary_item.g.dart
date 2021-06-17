// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryItemAdapter extends TypeAdapter<DiaryItem> {
  @override
  final int typeId = 5;

  @override
  DiaryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryItem(
      text: fields[0] as String,
      images: (fields[1] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DiaryItem obj) {
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
      other is DiaryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
