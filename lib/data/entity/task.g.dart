// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 2;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[0] as String,
      createdDate: fields[1] as String,
      updatedDate: fields[2] as String,
      priorityType: fields[3] as int,
      taskName: fields[4] as String,
      description: fields[5] as String,
      projectName: fields[6] as String,
      isCompleted: fields[7] as bool,
      isStarred: fields[8] as bool,
      isTrashed: fields[9] as bool,
      taskDate: fields[10] as String,
      projectId: fields[11] as String,
      labelName: fields[12] as String,
      labelId: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.updatedDate)
      ..writeByte(3)
      ..write(obj.priorityType)
      ..writeByte(4)
      ..write(obj.taskName)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.projectName)
      ..writeByte(7)
      ..write(obj.isCompleted)
      ..writeByte(8)
      ..write(obj.isStarred)
      ..writeByte(9)
      ..write(obj.isTrashed)
      ..writeByte(10)
      ..write(obj.taskDate)
      ..writeByte(11)
      ..write(obj.projectId)
      ..writeByte(12)
      ..write(obj.labelName)
      ..writeByte(13)
      ..write(obj.labelId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
