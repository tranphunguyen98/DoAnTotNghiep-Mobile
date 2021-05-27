import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/data_source/task/local_task_data_source.dart';
import 'package:totodo/data/data_source/task/remote_task_data_source.dart';
import 'package:totodo/data/data_source/user/local_user_data_source.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/local/mapper/local_task_mapper.dart';
import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/util.dart';

//TODO refactor localMapper
class TaskRepositoryImpl implements ITaskRepository {
  final RemoteTaskDataSource _remoteTaskDataSource;
  final LocalTaskDataSource _localTaskDataSource;
  final LocalUserDataSource _localUserDataSource;
  final LocalTaskMapper _localTaskMapper;

  TaskRepositoryImpl(this._remoteTaskDataSource, this._localTaskDataSource,
      this._localUserDataSource, this._localTaskMapper);

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
    return listTask.where((element) => element.isTrashed != true).toList();
  }

  @override
  Future<bool> updateTask(Task task) async {
    final user = await _localUserDataSource.getUser();
    final localTask = _localTaskMapper.mapToLocal(task);

    _remoteTaskDataSource.updateTask(user.authorization, task).then(
          (value) => _localTaskDataSource
              .updateTask(localTask.copyWith(isLocal: false)),
        );

    return _localTaskDataSource.updateTask(localTask.copyWith(isLocal: true));
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
    // return _localTaskDataSource.addLabel(label);
  }

  @override
  Future<List<Label>> getLabels() async {
    final labels = await _localTaskDataSource.getLabels();
    return labels.where((label) => label.isTrashed != true).toList();
  }

  @override
  Future<void> updateLabel(Label label) {
    return _localTaskDataSource.updateLabel(label);
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
  Future<void> deleteSection(String projectId, String sectionId) {
    return _localTaskDataSource.deleteSection(projectId, sectionId);
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

  @override
  Future<void> deleteProject(String projectId) {
    return _localTaskDataSource.deleteProject(projectId);
  }

  @override
  Future<void> deleteTask(Task task) async {
    //TODO handle access token
    final user = await _localUserDataSource.getUser();
    final localTask = _localTaskMapper.mapToLocal(task);

    _remoteTaskDataSource.deleteTask(user.authorization, task.id).then((value) {
      _localTaskDataSource.deleteTask(task.id);
    });

    return _localTaskDataSource
        .updateTask(localTask.copyWith(isTrashed: true, isLocal: true));
  }

  @override
  Future<bool> asyncData() async {
    log('testAsync async....');
    final user = await _localUserDataSource.getUser();

    final allLocalTasks = await _localTaskDataSource.getAllTask();
    final notAsyncTasks = allLocalTasks.where((task) => task.isLocal == true);
    final serverTasks =
        await _remoteTaskDataSource.getAllTask(user.authorization);

    log('testAsync', notAsyncTasks);
    final futures = <Future>[];

    for (final task in notAsyncTasks) {
      //Delete on local
      if (task.isTrashed) {
        futures.add(_remoteTaskDataSource
            .deleteTask(user.authorization, task.id)
            .then((value) async => _localTaskDataSource.deleteTask(task.id)));
      }
    }

    for (final localTask in allLocalTasks) {
      final serverTaskIndex =
          serverTasks.indexWhere((element) => element.id == localTask.id);

      //Delete on server
      if (serverTaskIndex < 0) {
        log('testAsync ${localTask.name}');
        futures.add(_localTaskDataSource.deleteTask(localTask.id));
      } else {
        final comparedLocalAndServerDate = DateHelper.compareStringTime(
            localTask.updatedAt, serverTasks[serverTaskIndex].updatedAt);

        log('testAsync $comparedLocalAndServerDate ${localTask.name}');

        if (comparedLocalAndServerDate > 0) {
          //Latest update on local
          futures.add(
              _remoteTaskDataSource.updateTask(user.authorization, localTask));
        } else if (comparedLocalAndServerDate < 0) {
          //Latest update on server
          futures.add(
              _localTaskDataSource.updateTask(serverTasks[serverTaskIndex]));
        }
      }
    }

    await Future.wait(futures);
    return true;
  }

  @override
  Future<void> checkServer() async {
    final user = await _localUserDataSource.getUser();
    try {
      await _remoteTaskDataSource.getLabels(user.authorization);
    } catch (e) {
      rethrow;
    }
  }
}
