import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'label.g.dart';

@HiveType(typeId: kHiveTypeLabel)
class Label extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String color;
  @HiveField(3)
  final String createdAt;
  @HiveField(4)
  final String updatedAt;
  @HiveField(5)
  final bool isTrashed;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Label({
    @required this.id,
    @required this.name,
    @required this.color,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.isTrashed,
  });

  Label copyWith({
    String id,
    String name,
    String color,
    String createdAt,
    String updatedAt,
    bool isTrashed,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (color == null || identical(color, this.color)) &&
        (createdAt == null || identical(createdAt, this.createdAt)) &&
        (updatedAt == null || identical(updatedAt, this.updatedAt)) &&
        (isTrashed == null || identical(isTrashed, this.isTrashed))) {
      return this;
    }

    return Label(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isTrashed: isTrashed ?? this.isTrashed,
    );
  }

  @override
  String toString() {
    return 'Label{id: $id, name: $name, color: $color, createdAt: $createdAt, updatedAt: $updatedAt, isTrashed: $isTrashed}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Label &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          color == other.color &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          isTrashed == other.isTrashed);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      color.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      isTrashed.hashCode;

  factory Label.fromJson(Map<String, dynamic> map) {
    return Label(
      id: map['id'] as String,
      name: map['name'] as String,
      color: map['color'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      isTrashed: map['isTrashed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
      'color': this.color,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'isTrashed': this.isTrashed,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props => [id, name, color, createdAt, updatedAt];
}
