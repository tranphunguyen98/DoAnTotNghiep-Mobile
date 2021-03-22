import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'check_item.g.dart';

@HiveType(typeId: 8)
class CheckItem extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDone;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const CheckItem({
    @required this.id,
    @required this.name,
    this.isDone = false,
  });

  CheckItem copyWith({
    String id,
    String name,
    bool isCheck,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (isCheck == null || identical(isCheck, this.isDone))) {
      return this;
    }

    return CheckItem(
      id: id ?? this.id,
      name: name ?? this.name,
      isDone: isCheck ?? this.isDone,
    );
  }

  @override
  String toString() {
    return 'CheckItem{id: $id, name: $name, isCheck: $isDone}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          isDone == other.isDone);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isDone.hashCode;

  factory CheckItem.fromMap(Map<String, dynamic> map) {
    return CheckItem(
      id: map['id'] as String,
      name: map['name'] as String,
      isDone: map['isCheck'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': id,
      'name': name,
      'isCheck': isDone,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props => [id, name, isDone];
}
