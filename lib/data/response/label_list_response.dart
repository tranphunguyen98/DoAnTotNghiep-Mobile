import 'package:totodo/data/entity/label.dart';
import 'package:totodo/utils/util.dart';

class LabelListResponse {
  final bool succeeded;
  final String message;
  final List<Label> labels;

  LabelListResponse({
    this.succeeded,
    this.message,
    this.labels,
  });

  factory LabelListResponse.fromJson(Map<String, dynamic> json) {
    log('json', json);
    final result = json['result'] as List;

    return LabelListResponse(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      labels: result
          .map((label) => Label.fromJson(label as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'LabelListResponse{succeeded: $succeeded, message: $message, labels: $labels}';
  }
}
