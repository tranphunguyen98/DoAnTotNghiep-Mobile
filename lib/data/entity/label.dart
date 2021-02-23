import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'label.g.dart';

@HiveType(typeId: 4)
class Label extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String nameLabel;
  @HiveField(2)
  final String color;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Label({
    this.id,
    this.nameLabel,
    this.color,
  });

  Label copyWith({
    String id,
    String nameLabel,
    String color,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (nameLabel == null || identical(nameLabel, this.nameLabel)) &&
        (color == null || identical(color, this.color))) {
      return this;
    }

    return Label(
      id: id ?? this.id,
      nameLabel: nameLabel ?? this.nameLabel,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'Label{id: $id, nameLabel: $nameLabel, color: $color}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Label &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nameLabel == other.nameLabel &&
          color == other.color);

  @override
  int get hashCode => id.hashCode ^ nameLabel.hashCode ^ color.hashCode;

  factory Label.fromJson(Map<String, dynamic> map) {
    return Label(
      id: map['id'] as String,
      nameLabel: map['nameLabel'] as String,
      color: map['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'nameLabel': this.nameLabel,
      'color': this.color,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props => [id, nameLabel, color];
}
