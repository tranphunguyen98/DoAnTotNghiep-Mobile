import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';

abstract class LocalTaskDataSource {
  Future<bool> addTask(Task task);
  Future<Task> getDetailTask(String id);
  Future<List<Task>> getAllTask();
  Future<bool> updateTask(Task task);

  Future<void> addProject(Project project);
  Future<void> updateProject(Project project);
  Future<List<Project>> getProjects();

  Future<void> addLabel(Label label);
  Future<void> updateLabel(Label label);
  Future<List<Label>> getLabels();

  Future<void> addSection(Section section);
  Future<void> updateSection(Section section);
  Future<List<Section>> getSections();
}
