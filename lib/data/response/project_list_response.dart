import 'package:totodo/data/entity/project.dart';
import 'package:totodo/utils/util.dart';

class ProjectListResponse {
  final bool succeeded;
  final String message;
  final List<Project> projects;

  ProjectListResponse({
    this.succeeded,
    this.message,
    this.projects,
  });

  factory ProjectListResponse.fromJson(Map<String, dynamic> json) {
    log('json', json);
    final result = json['result'] as List;

    return ProjectListResponse(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      projects: result
          .map((project) => Project.fromJson(project as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ProjectResponse{succeeded: $succeeded, message: $message, projects: $projects}';
  }
}
