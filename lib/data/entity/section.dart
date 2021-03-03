import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'section.g.dart';

@HiveType(typeId: 7)
class Section extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  final bool isShowIfEmpty;
  static const Section kSectionToday =
      Section(id: "today", name: "Today", isShowIfEmpty: false);
  static const Section kSectionOverdue =
      Section(id: "overdue", name: "Overdue", isShowIfEmpty: false);
  static const Section kSectionNoName = Section(id: "noName", name: "");

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Section({
    @required this.id,
    @required this.name,
    this.isShowIfEmpty = true,
  });

  Section copyWith({
    String id,
    String name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return Section(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Label{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Section &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
