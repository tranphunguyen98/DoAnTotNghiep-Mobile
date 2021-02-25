import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'project.g.dart';

@HiveType(typeId: 6)
class Project extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String color;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Project({
    this.id,
    this.name,
    this.color,
  });

  Project copyWith({
    String id,
    String name,
    String color,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (color == null || identical(color, this.color))) {
      return this;
    }

    return new Project(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'Project{id: $id, name: $name, color: $color}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          color == other.color);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ color.hashCode;

  factory Project.fromMap(Map<String, dynamic> map) {
    return new Project(
      id: map['id'] as String,
      name: map['name'] as String,
      color: map['color'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
      'color': this.color,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props => [id, name, color];
}
