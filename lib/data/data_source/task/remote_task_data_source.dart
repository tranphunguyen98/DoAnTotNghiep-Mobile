import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/local/model/local_task.dart';

abstract class RemoteTaskDataSource {
  Future<LocalTask> addTask(String authorization, Task task);

  Future<Task> getDetailTask(String authorization, String id);

  Future<List<LocalTask>> getAllTask(String authorization);

  Future<Project> addProject(String authorization, Project project);

  Future<void> updateProject(String authorization, Project project);

  Future<List<Project>> getProjects(String authorization);

  Future<Label> addLabel(String authorization, Label label);

  Future<void> updateLabel(String authorization, Label label);

  Future<List<Label>> getLabels(String authorization);
}
