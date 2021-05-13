import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';

abstract class ITaskRepository {
  Future<bool> addTask(Task task);
  Future<bool> updateTask(Task task);
  Future<Task> getDetailTask(String id);
  Future<List<Task>> getAllTask();

  Future<void> addProject(Project project);
  Future<void> updateProject(Project project);
  Future<List<Project>> getProjects({bool onlyRemote = false});

  Future<void> addLabel(Label label);
  Future<void> updateLabel(Label label);
  Future<List<Label>> getLabels();

  // Future<void> addSection(SectionDisplay section);
  // Future<void> updateSection(SectionDisplay section);
  // Future<List<SectionDisplay>> getSections();
  Future<void> saveDataToLocal();
  Future<void> clearDataOffline();
}
