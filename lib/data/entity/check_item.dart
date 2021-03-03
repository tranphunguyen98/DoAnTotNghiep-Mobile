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
  final bool isCheck;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const CheckItem({
    @required this.id,
    @required this.name,
    this.isCheck = false,
  });

  CheckItem copyWith({
    String id,
    String name,
    bool isCheck,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (isCheck == null || identical(isCheck, this.isCheck))) {
      return this;
    }

    return CheckItem(
      id: id ?? this.id,
      name: name ?? this.name,
      isCheck: isCheck ?? this.isCheck,
    );
  }

  @override
  String toString() {
    return 'CheckItem{id: $id, name: $name, isCheck: $isCheck}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          isCheck == other.isCheck);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isCheck.hashCode;

  factory CheckItem.fromMap(Map<String, dynamic> map) {
    return CheckItem(
      id: map['id'] as String,
      name: map['name'] as String,
      isCheck: map['isCheck'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
      'isCheck': this.isCheck,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props => [id, name, isCheck];
}
