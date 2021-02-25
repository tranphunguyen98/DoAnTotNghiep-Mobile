// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalTaskAdapter extends TypeAdapter<LocalTask> {
  @override
  final int typeId = 5;

  @override
  LocalTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalTask(
      id: fields[0] as String,
      createdDate: fields[1] as String,
      updatedDate: fields[2] as String,
      priorityType: fields[3] as int,
      name: fields[4] as String,
      description: fields[5] as String,
      isCompleted: fields[6] as bool,
      isStarred: fields[7] as bool,
      isTrashed: fields[8] as bool,
      taskDate: fields[9] as String,
      projectId: fields[10] as String,
      labelIds: (fields[11] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, LocalTask obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.updatedDate)
      ..writeByte(3)
      ..write(obj.priorityType)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.isCompleted)
      ..writeByte(7)
      ..write(obj.isStarred)
      ..writeByte(8)
      ..write(obj.isTrashed)
      ..writeByte(9)
      ..write(obj.taskDate)
      ..writeByte(10)
      ..write(obj.projectId)
      ..writeByte(11)
      ..write(obj.labelIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
