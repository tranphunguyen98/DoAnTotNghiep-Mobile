import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';

abstract class RemoteTaskDataSource {
  Future<bool> addTask(String authorization, Task task);

  Future<Task> getDetailTask(String authorization, String id);

  Future<List<Task>> getAllTask(
    String authorization,
  );

  Future<Project> addProject(String authorization, Project project);

  Future<void> updateProject(String authorization, Project project);

  Future<List<Project>> getProjects(
    String authorization,
  );
}
