import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';

abstract class LocalTaskDataSource {
  Future<bool> addTask(Task task);

  Future<Task> getDetailTask(String id);

  Future<List<Task>> getAllTask();

  Future<bool> updateTask(Task task);

  Future<void> addProject(Project project);
  Future<void> updateProject(Project project);
}
