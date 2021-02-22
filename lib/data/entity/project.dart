import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'project.g.dart';

@HiveType(typeId: 1)
class Project extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String nameProject;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Project({
    this.id,
    this.nameProject,
  });

  Project copyWith({
    int id,
    String nameProject,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (nameProject == null || identical(nameProject, this.nameProject))) {
      return this;
    }

    return Project(
      id: id ?? this.id,
      nameProject: nameProject ?? this.nameProject,
    );
  }

  @override
  String toString() {
    return 'Project{id: $id, nameProject: $nameProject}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nameProject == other.nameProject);

  @override
  int get hashCode => id.hashCode ^ nameProject.hashCode;

  factory Project.fromJson(Map<String, dynamic> map) {
    return Project(
      id: map['id'] as int,
      nameProject: map['nameProject'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'nameProject': this.nameProject,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props => [id, nameProject];
}
