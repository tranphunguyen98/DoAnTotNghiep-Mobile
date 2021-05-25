import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'project.g.dart';

@HiveType(typeId: kHiveTypeProject)
class Project extends Equatable {
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
  final List<Section> sections;
  final bool isLocal;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Project(
      {@required this.id,
      @required this.name,
      @required this.color,
      @required this.createdAt,
      @required this.updatedAt,
      @required this.sections,
      this.isLocal = false});

  Project copyWith({
    String id,
    String name,
    String color,
    String createdAt,
    String updatedAt,
    List<Section> sections,
    bool isLocal,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sections: sections ?? this.sections,
      isLocal: isLocal ?? this.isLocal,
    );
  }

  @override
  String toString() {
    return 'Project{id: $id, name: $name, color: $color, createdAt: $createdAt, updatedAt: $updatedAt, sections: $sections, isLocal: $isLocal}';
  }

  factory Project.fromJson(Map<String, dynamic> map) {
    return Project(
      id: map['_id'] as String,
      name: map['name'] as String,
      color: map['color'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      sections: (map['sections'] as List)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      '_id': id,
      'name': name,
      'color': color,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'sections': sections,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props =>
      [id, name, color, createdAt, updatedAt, sections, isLocal];
}
