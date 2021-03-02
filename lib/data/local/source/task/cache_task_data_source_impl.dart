import 'package:totodo/data/data_source/task/local_task_data_source.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';

import 'local_task_service.dart';

class LocalTaskDataSourceImplement implements LocalTaskDataSource {
  final LocalTaskService _taskService;

  const LocalTaskDataSourceImplement(this._taskService);

  @override
  Future<bool> addTask(Task task) => _taskService.addTask(task);

  @override
  Future<Task> getDetailTask(String id) {
    // TODO: implement getTaskInbox
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTask() async {
    return _taskService.getAllTask();
  }

  @override
  Future<bool> updateTask(Task task) async {
    return _taskService.updateTask(task);
  }

  @override
  Future<void> addProject(Project project) {
    return _taskService.addProject(project);
  }

  @override
  Future<void> updateProject(Project project) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }

  @override
  Future<List<Project>> getProjects() {
    return _taskService.getProjects();
  }

  @override
  Future<void> addLabel(Label label) {
    return _taskService.addLabel(label);
  }

  @override
  Future<List<Label>> getLabels() {
    return _taskService.getLabels();
  }

  @override
  Future<void> updateLabel(Label label) {
    // TODO: implement updateLabel
    throw UnimplementedError();
  }
}