import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/data_source/task/local_task_data_source.dart';
import 'package:totodo/data/data_source/task/remote_task_data_source.dart';
import 'package:totodo/data/data_source/user/local_user_data_source.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/local/model/local_task.dart';

class TaskRepositoryImpl implements ITaskRepository {
  final RemoteTaskDataSource _remoteTaskDataSource;
  final LocalTaskDataSource _localTaskDataSource;
  final LocalUserDataSource _localUserDataSource;

  TaskRepositoryImpl(this._remoteTaskDataSource, this._localTaskDataSource,
      this._localUserDataSource);

  @override
  Future<bool> addTask(Task task) async {
    final user = await _localUserDataSource.getUser();
    try {
      final serverTask =
          await _remoteTaskDataSource.addTask(user.authorization, task);
      return _localTaskDataSource.addTask(serverTask);
    } catch (e) {
      // TODO try remove :v
      rethrow;
    }
  }

  @override
  Future<Task> getDetailTask(String id) {
    return _localTaskDataSource.getDetailTask(id);
  }

  @override
  Future<List<Task>> getAllTask() async {
    final listTask = await _localTaskDataSource.getAllTask();
    return listTask.where((element) => element.isTrashed == false).toList();
  }

  @override
  Future<bool> updateTask(Task task) async {
    final user = await _localUserDataSource.getUser();
    try {
      _remoteTaskDataSource.updateTask(user.authorization, task);
      return _localTaskDataSource.updateTask(task);
    } catch (e) {
      // TODO try remove :v

      rethrow;
    }
  }

  @override
  Future<void> addProject(Project project) async {
    final user = await _localUserDataSource.getUser();
    final serverProject =
        await _remoteTaskDataSource.addProject(user.authorization, project);
    return _localTaskDataSource.addProject(serverProject);
  }

  @override
  Future<void> updateProject(Project project) {
    return _localTaskDataSource.updateProject(project);
  }

  @override
  Future<List<Project>> getProjects({bool onlyRemote = false}) async {
    if (onlyRemote) {
      final user = await _localUserDataSource.getUser();
      final List<Project> projects =
          await _remoteTaskDataSource.getProjects(user.authorization);
      return projects;
    }
    return _localTaskDataSource.getProjects();
  }

  @override
  Future<void> addLabel(Label label) async {
    final user = await _localUserDataSource.getUser();
    // try {
    final serverLabel =
        await _remoteTaskDataSource.addLabel(user.authorization, label);
    return _localTaskDataSource.addLabel(serverLabel);
    // } catch (e) {
    //   // TODO try remove :v
    //   rethrow;
    // }
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
  Future<void> clearDataOffline() {
    return _localTaskDataSource.clearData();
  }

  @override
  Future<void> addSection(String projectId, Section section) async {
    // return _localTaskDataSource.addSection(projectId, section);
    final user = await _localUserDataSource.getUser();
    final serverSection = await _remoteTaskDataSource.addSection(
        user.authorization, projectId, section);
    await _localTaskDataSource.addSection(projectId, section);
  }

  @override
  Future<void> deleteSection(String projectId, Section section) {
    // TODO: implement deleteSection
    throw UnimplementedError();
  }

  @override
  Future<void> updateSection(String projectId, Section section) {
    // TODO: implement updateSection
    throw UnimplementedError();
  }

  @override
  Future<void> saveDataToLocal() async {
    final user = await _localUserDataSource.getUser();

    final List<Project> projects =
        await _remoteTaskDataSource.getProjects(user.authorization);
    final List<Label> labels =
        await _remoteTaskDataSource.getLabels(user.authorization);
    final List<LocalTask> tasks =
        await _remoteTaskDataSource.getAllTask(user.authorization);

    await _localTaskDataSource.saveProjects(projects);
    await _localTaskDataSource.saveLabels(labels);
    await _localTaskDataSource.saveTasks(tasks);
  }
}
