import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/model/section.dart';
import 'package:totodo/data/model/task.dart';

abstract class ITaskRepository {
  Future<void> addTask(Task task);
  Future<bool> updateTask(Task task);
  Future<Task> getDetailTask(String id);
  Future<List<Task>> getAllTask();
  Future<void> deleteTask(Task task);

  Future<void> addProject(Project project);
  Future<void> updateProject(Project project);
  Future<List<Project>> getProjects({bool onlyRemote = false});
  Future<void> deleteProject(String projectId);

  Future<void> addLabel(Label label);
  Future<void> updateLabel(Label label);
  Future<List<Label>> getLabels();

  Future<void> addSection(String projectId, Section section);
  Future<void> updateSection(String projectId, Section section);
  Future<void> deleteSection(String projectId, String sectionId);
  // Future<List<SectionDisplay>> getSections();
  Future<void> saveDataToLocal();
  Future<void> clearDataOffline();
  Future<bool> asyncData();
  Future<void> checkServer();
}