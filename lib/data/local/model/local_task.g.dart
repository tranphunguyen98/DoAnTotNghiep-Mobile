// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalTaskAdapter extends TypeAdapter<LocalTask> {
  @override
  final int typeId = 0;

  @override
  LocalTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalTask(
      id: fields[0] as String,
      createdAt: fields[1] as String,
      updatedAt: fields[2] as String,
      priority: fields[3] as int,
      name: fields[4] as String,
      description: fields[5] as String,
      isCompleted: fields[6] as bool,
      isStarred: fields[7] as bool,
      isTrashed: fields[8] as bool,
      dueDate: fields[9] as String,
      projectId: fields[10] as String,
      labelIds: (fields[11] as List)?.cast<String>(),
      sectionId: fields[12] as String,
      checkList: (fields[13] as List)?.cast<CheckItem>(),
      completedDate: fields[14] as String,
      crontabSchedule: fields[15] as String,
      preciseSchedules: (fields[16] as List)?.cast<String>(),
      isLocal: fields[17] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocalTask obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.updatedAt)
      ..writeByte(3)
      ..write(obj.priority)
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
      ..write(obj.dueDate)
      ..writeByte(10)
      ..write(obj.projectId)
      ..writeByte(11)
      ..write(obj.labelIds)
      ..writeByte(12)
      ..write(obj.sectionId)
      ..writeByte(13)
      ..write(obj.checkList)
      ..writeByte(14)
      ..write(obj.completedDate)
      ..writeByte(15)
      ..write(obj.crontabSchedule)
      ..writeByte(16)
      ..write(obj.preciseSchedules)
      ..writeByte(17)
      ..write(obj.isLocal);
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
