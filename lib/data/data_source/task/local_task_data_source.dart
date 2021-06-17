import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/model/section.dart';

abstract class LocalTaskDataSource {
  Future<String> addTask(LocalTask task);

  Future<LocalTask> getDetailTask(String id);

  Future<List<LocalTask>> getAllTask();

  Future<void> deleteTask(String taskId);

  Future<bool> updateTask(LocalTask task);

  Future<bool> updateTaskAsync(LocalTask task);

  Future<void> saveTasks(List<LocalTask> tasks);

  // Future<void> updateTaskId(String oldId, String newId);

  Future<void> addProject(Project project);

  Future<void> updateProject(Project project);

  Future<List<Project>> getProjects();

  Future<void> saveProjects(List<Project> projects);

  Future<void> deleteProject(String projectId);

  Future<void> addLabel(Label label);

  Future<void> updateLabel(Label label);

  Future<List<Label>> getLabels();

  Future<void> saveLabels(List<Label> labels);

  Future<void> deleteLabel(String labelId);

  Future<void> addSection(String projectId, Section section);

  Future<void> updateSection(String projectId, Section section);

  Future<void> deleteSection(String projectId, String sectionId);

  // Future<void> updateSection(SectionDisplay section);
  // Future<List<SectionDisplay>> getSections();

  Future<void> clearData();
}
