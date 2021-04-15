import 'package:equatable/equatable.dart';
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

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Label({
    this.id,
    this.name,
    this.color,
  });

  Label copyWith({
    String id,
    String nameLabel,
    String color,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (nameLabel == null || identical(nameLabel, name)) &&
        (color == null || identical(color, this.color))) {
      return this;
    }

    return Label(
      id: id ?? this.id,
      name: nameLabel ?? name,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'Label{id: $id, nameLabel: $name, color: $color}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Label &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          color == other.color);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ color.hashCode;

  factory Label.fromJson(Map<String, dynamic> map) {
    return Label(
      id: map['id'] as String,
      name: map['nameLabel'] as String,
      color: map['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'id': id,
      'nameLabel': name,
      'color': color,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props => [id, name, color];
}
