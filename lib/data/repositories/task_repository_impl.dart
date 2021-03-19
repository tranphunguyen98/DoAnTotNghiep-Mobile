import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/data_source/task/local_task_data_source.dart';
import 'package:totodo/data/data_source/task/remote_task_data_source.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';

class TaskRepositoryImpl implements ITaskRepository {
  final RemoteTaskDataSource _remoteTaskDataSource;
  final LocalTaskDataSource _localTaskDataSource;

  TaskRepositoryImpl(this._remoteTaskDataSource, this._localTaskDataSource);

  @override
  Future<bool> addTask(Task task) {
    return _localTaskDataSource.addTask(task);
  }

  @override
  Future<Task> getDetailTask(String id) {
    return _localTaskDataSource.getDetailTask(id);
  }

  @override
  Future<List<Task>> getAllTask() {
    return _localTaskDataSource.getAllTask();
  }

  @override
  Future<bool> updateTask(Task task) {
    return _localTaskDataSource.updateTask(task);
  }

  @override
  Future<void> addProject(Project project) {
    return _localTaskDataSource.addProject(project);
  }

  @override
  Future<void> updateProject(Project project) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }

  @override
  Future<List<Project>> getProjects() {
    return _localTaskDataSource.getProjects();
  }

  @override
  Future<void> addLabel(Label label) {
    return _localTaskDataSource.addLabel(label);
  }

  @override
  Future<List<Label>> getLabels() {
    return _localTaskDataSource.getLabels();
  }

  @override
  Future<void> updateLabel(Label label) {
    // TODO: implement updateLabel
    throw UnimplementedError();
  }

  @override
  Future<void> addSection(Section section) {
    return _localTaskDataSource.addSection(section);
  }

  @override
  Future<List<Section>> getSections() {
    return _localTaskDataSource.getSections();
  }

  @override
  Future<void> updateSection(Section section) {
    // TODO: implement updateSection
    throw UnimplementedError();
  }

  @override
  Future<void> clearData() {
    return _localTaskDataSource.clearData();
  }
}
