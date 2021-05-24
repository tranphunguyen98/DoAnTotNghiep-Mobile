import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/local/model/local_task.dart';

abstract class LocalTaskDataSource {
  Future<bool> addTask(LocalTask task);
  Future<Task> getDetailTask(String id);
  Future<List<Task>> getAllTask();
  Future<bool> updateTask(Task task);
  Future<void> saveTasks(List<LocalTask> tasks);

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
