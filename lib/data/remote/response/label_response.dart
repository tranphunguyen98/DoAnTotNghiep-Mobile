import 'package:totodo/data/model/label.dart';

class LabelResponse {
  final bool succeeded;
  final String message;
  final Label label;

  LabelResponse({
    this.succeeded,
    this.message,
    this.label,
  });

  factory LabelResponse.fromJson(Map<String, dynamic> json) {
    final result = json['result'] as Map<String, dynamic>;

    return LabelResponse(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      label: Label.fromJson(result),
    );
  }

  @override
  String toString() {
    return 'LabelResponse{succeeded: $succeeded, message: $message, label: $label}';
  }
}
