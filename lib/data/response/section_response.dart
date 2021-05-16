import 'package:totodo/data/entity/section.dart';

class ListSectionResponse {
  final bool succeeded;
  final String message;
  final List<Section> sections;

  ListSectionResponse({
    this.succeeded,
    this.message,
    this.sections,
  });

  factory ListSectionResponse.fromJson(Map<String, dynamic> json) {
    final result = json['result'] as List;

    return ListSectionResponse(
        succeeded: json['succeeded'] as bool,
        message: json['message'] as String,
        sections: result
            .map(
              (e) => Section.fromJson(e as Map<String, dynamic>),
            )
            .toList());
  }

  @override
  String toString() {
    return 'SectionResponse{succeeded: $succeeded, message: $message, sections: $sections}';
  }
}
