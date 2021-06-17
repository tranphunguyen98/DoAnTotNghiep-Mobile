import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/model/section.dart';

abstract class RemoteTaskDataSource {
  Future<LocalTask> addTask(String authorization, LocalTask localTask);

  Future<LocalTask> getDetailTask(String authorization, String id);

  Future<LocalTask> updateTask(String authorization, LocalTask task);

  Future<List<LocalTask>> getAllTask(String authorization);

  Future<void> deleteTask(String authorization, String taskId);

  Future<Project> addProject(String authorization, Project project);

  Future<void> updateProject(String authorization, Project project);

  Future<List<Project>> getProjects(String authorization);

  Future<Label> addLabel(String authorization, Label label);

  Future<void> updateLabel(String authorization, Label label);

  Future<List<Label>> getLabels(String authorization);

  Future<Section> addSection(
      String authorization, String projectId, Section section);

  Future<void> updateSection(
      String authorization, String projectId, Section section);

  Future<void> deleteSection(
      String authorization, String projectId, Section section);
}
