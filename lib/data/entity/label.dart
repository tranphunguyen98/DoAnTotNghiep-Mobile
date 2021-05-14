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

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Label({
    @required this.id,
    @required this.name,
    @required this.color,
    @required this.createdAt,
    @required this.updatedAt,
  });

  Label copyWith({
    String id,
    String name,
    String color,
    String createdAt,
    String updatedAt,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (color == null || identical(color, this.color)) &&
        (createdAt == null || identical(createdAt, this.createdAt)) &&
        (updatedAt == null || identical(updatedAt, this.updatedAt))) {
      return this;
    }

    return new Label(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Label{id: $id, name: $name, color: $color, createdAt: $createdAt, updatedAt: $updatedAt}';
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
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      color.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  factory Label.fromJson(Map<String, dynamic> map) {
    return Label(
      id: map['_id'] as String,
      name: map['name'] as String,
      color: map['color'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      '_id': this.id,
      'name': this.name,
      'color': this.color,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props => [id, name, color, createdAt, updatedAt];
}
