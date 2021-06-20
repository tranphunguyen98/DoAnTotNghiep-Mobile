import 'package:dio/dio.dart';
import 'package:objectid/objectid.dart';
import 'package:totodo/data/data_source/task/local_task_data_source.dart';
import 'package:totodo/data/data_source/task/remote_task_data_source.dart';
import 'package:totodo/data/data_source/user/local_user_data_source.dart';
import 'package:totodo/data/data_source/user/remote_user_data_source.dart';
import 'package:totodo/data/local/mapper/local_task_mapper.dart';
import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/model/section.dart';
import 'package:totodo/data/model/task.dart';
import 'package:totodo/data/remote/exception/unauthenticated_exception.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/util.dart';

//TODO refactor localMapper
class TaskRepositoryImpl implements ITaskRepository {
  final RemoteTaskDataSource _remoteTaskDataSource;
  final LocalTaskDataSource _localTaskDataSource;
  final LocalUserDataSource _localUserDataSource;
  final RemoteUserDataSource _remoteUserDataSource;
  final LocalTaskMapper _localTaskMapper;

  TaskRepositoryImpl(
      this._remoteTaskDataSource,
      this._localTaskDataSource,
      this._localUserDataSource,
      this._remoteUserDataSource,
      this._localTaskMapper);

  @override
  Future<void> addTask(Task task) async {
    final user = await _localUserDataSource.getUser();

    final localTask = _localTaskMapper.mapToLocal(
        task.copyWith(id: ObjectId().hexString, isCreatedOnLocal: true));

    // log('testAsync id: ${localTask.id}');

    try {
      // _remoteTaskDataSource
      //     .addTask(user.authorization, localTask)
      //     .then((value) async {
      //   final updatedLocalTask = await _remoteTaskDataSource.getDetailTask(
      //       user.authorization, localTask.id);
      //   await _localTaskDataSource.updateTaskAsync(updatedLocalTask);
      // });

      return _localTaskDataSource.addTask(localTask);
    } on UnauthenticatedException catch (e) {
      log('UnauthenticatedException', e);
      // await _remoteUserDataSource.renewUser(user);
      // await addTask(task);
    } on DioError catch (e, stackTrace) {
      log('testAsync', 'server error $stackTrace');
    } on Exception catch (e) {
      log('testAsync', 'server error $e');
    }
  }

  @override
  Future<Task> getDetailTask(String id) async {
    final localTaskMapper = LocalTaskMapper(
        listLabel: await getLabels(), listProject: await getProjects());
    return localTaskMapper
        .mapFromLocal(await _localTaskDataSource.getDetailTask(id));
  }

  @override
  Future<List<Task>> getAllTask() async {
    final listTask = await _localTaskDataSource.getAllTask();

    final mapper = LocalTaskMapper(
        listLabel: await _localTaskDataSource.getLabels(),
        listProject: await _localTaskDataSource.getProjects());

    return listTask
        .where((task) => task.isTrashed != true)
        .map((e) => mapper.mapFromLocal(e))
        .toList();
  }

  @override
  Future<bool> updateTask(Task task) async {
    final user = await _localUserDataSource.getUser();
    final localTask = _localTaskMapper.mapToLocal(task);

    // _remoteTaskDataSource
    //     .updateTask(user.authorization, localTask)
    //     .then((value) async {
    //   // log('testAsync updated task', updatedLocalTask);
    //   // log('testAsync updated task1',
    //   // await _localTaskDataSource.getDetailTask(updatedLocalTask.id));
    //   final updatedLocalTask = await _remoteTaskDataSource.getDetailTask(
    //       user.authorization, localTask.id);
    //   await _localTaskDataSource.updateTaskAsync(updatedLocalTask);
    //
    //   // log('testAsync updated task1',
    //   //     await _localTaskDataSource.getDetailTask(updatedLocalTask.id));
    // });

    return _localTaskDataSource.updateTask(localTask);
  }

  @override
  Future<void> addProject(Project project) async {
    final user = await _localUserDataSource.getUser();
    // final serverProject =
    //     await _remoteTaskDataSource.addProject(user.authorization, project);
    // return _localTaskDataSource.addProject(serverProject);
    return _localTaskDataSource.addProject(project);
  }

  @override
  Future<void> updateProject(Project project) {
    return _localTaskDataSource.updateProject(project);
  }

  @override
  Future<List<Project>> getProjects({bool onlyRemote = false}) async {
    // if (onlyRemote) {
    //   final user = await _localUserDataSource.getUser();
    //   final List<Project> projects =
    //       await _remoteTaskDataSource.getProjects(user.authorization);
    //   return projects;
    // }
    return _localTaskDataSource.getProjects();
  }

  @override
  Future<void> addLabel(Label label) async {
    final user = await _localUserDataSource.getUser();
    // try {
    // final serverLabel =
    //     await _remoteTaskDataSource.addLabel(user.authorization, label);
    // return _localTaskDataSource.addLabel(serverLabel);
    // // } catch (e) {
    // //   // TODO try remove :v
    // //   rethrow;
    // // }
    return _localTaskDataSource.addLabel(label);
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
    // final serverSection = await _remoteTaskDataSource.addSection(
    //     user.authorization, projectId, section);
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
    //
    // final List<Project> projects =
    //     await _remoteTaskDataSource.getProjects(user.authorization);
    // final List<Label> labels =
    //     await _remoteTaskDataSource.getLabels(user.authorization);
    // final List<LocalTask> tasks =
    //     await _remoteTaskDataSource.getAllTask(user.authorization);
    //
    // await _localTaskDataSource.saveProjects(projects);
    // await _localTaskDataSource.saveLabels(labels);
    // await _localTaskDataSource.saveTasks(tasks);
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
    //
    // _remoteTaskDataSource.deleteTask(user.authorization, task.id).then((value) {
    //   _localTaskDataSource.deleteTask(task.id);
    // });

    return _localTaskDataSource.updateTask(localTask.copyWith(isTrashed: true));
  }

  @override
  Future<bool> asyncData() async {
    log('testAsync async....');
    // final user = await _localUserDataSource.getUser();
    //
    // final localTasks = await _localTaskDataSource.getAllTask();
    // final serverTasks =
    //     await _remoteTaskDataSource.getAllTask(user.authorization);
    //
    // final updatedLocalTasks = _getUpdatedLocalTask(localTasks, serverTasks);
    // final updatedServerTasks = _getUpdatedLocalTask(serverTasks, localTasks);
    //
    // log('testAsync local', localTasks);
    // log('testAsync server', serverTasks);
    // log('testAsync updated local', updatedLocalTasks);
    // log('testAsync updated server', updatedServerTasks);
    // // final futures = <Future>[];
    //
    // // user delete task on local
    // final deletedTaskOnLocal =
    //     updatedLocalTasks.where((task) => task.isTrashed).toList();
    // deletedTaskOnLocal.forEach((task) async {
    //   await _remoteTaskDataSource
    //       .deleteTask(user.authorization, task.id)
    //       .then((value) async => _localTaskDataSource.deleteTask(task.id));
    //   _removeHandedTask(updatedLocalTasks, updatedServerTasks, task);
    //   log('testAsync user delete on local ${task.name}');
    // });
    //
    // //User delete task on server
    // final deletedTaskOnServer = localTasks
    //     .where((localTask) =>
    //         !serverTasks.any((serverTask) => serverTask.id == localTask.id) &&
    //         !localTask.isCreatedOnLocal)
    //     .toList();
    // deletedTaskOnServer.forEach((localTask) async {
    //   log('testAsync user delete on server ${localTask.name}');
    //   await _localTaskDataSource.deleteTask(localTask.id);
    //   _removeHandedTask(updatedLocalTasks, updatedServerTasks, localTask);
    // });
    //
    // log('testAsync updated local deleted', deletedTaskOnLocal);
    // log('testAsync updated server deleted', deletedTaskOnServer);
    // log('testAsync updated local1', updatedLocalTasks);
    // log('testAsy nc updated server1', updatedServerTasks);
    // //User edited task on local
    // final editedTaskOnLocal = _getEditedTask(updatedLocalTasks, serverTasks);
    // for (final localTask in editedTaskOnLocal) {
    //   log('testAsync user edited on local ${localTask.name}');
    //   await _remoteTaskDataSource
    //       .updateTask(user.authorization, localTask)
    //       .then((value) async {
    //     final updatedLocalTask = await _remoteTaskDataSource.getDetailTask(
    //         user.authorization, localTask.id);
    //     await _localTaskDataSource.updateTaskAsync(updatedLocalTask);
    //   });
    //   _removeHandedTask(updatedLocalTasks, updatedServerTasks, localTask);
    // }
    //
    // //User edited task on Server
    // final editedTaskOnServer = _getEditedTask(updatedServerTasks, localTasks);
    // for (final serverTask in editedTaskOnServer) {
    //   log('testAsync user edited on server ${serverTask.name}');
    //   await _localTaskDataSource.updateTaskAsync(serverTask);
    //   _removeHandedTask(updatedLocalTasks, updatedServerTasks, serverTask);
    // }
    //
    // log('testAsync updated local edited', editedTaskOnLocal);
    // log('testAsync updated server edited', editedTaskOnServer);
    // log('testAsync updated local2', updatedLocalTasks);
    // log('testAsync updated server2', updatedServerTasks);
    // //User add task on local
    // final addedOnServer = updatedLocalTasks
    //     .where((localTask) =>
    //         !serverTasks.any((serverTask) => serverTask.id == localTask.id) &&
    //         localTask.isCreatedOnLocal)
    //     .toList();
    // addedOnServer.forEach((localTask) async {
    //   log('testAsync user created on local ${localTask.name}');
    //
    //   await _remoteTaskDataSource
    //       .addTask(user.authorization, localTask)
    //       .then((value) async {
    //     final updatedLocalTask = await _remoteTaskDataSource.getDetailTask(
    //         user.authorization, localTask.id);
    //     await _localTaskDataSource.updateTaskAsync(updatedLocalTask);
    //   });
    //   _removeHandedTask(updatedLocalTasks, updatedServerTasks, localTask);
    // });
    //
    // //User add task on server
    // updatedServerTasks
    //     .where((serverTask) =>
    //         !localTasks.any((localTask) => localTask.id == serverTask.id))
    //     .forEach((serverTask) async {
    //   log('testAsync user create task on server ${serverTask.name}');
    //   await _localTaskDataSource.addTask(serverTask);
    // });
    // log('testAsync updated local', updatedLocalTasks);
    // log('testAsync updated server', updatedServerTasks);
    // // await Future.wait(futures);
    return true;
  }

  void _removeHandedTask(List<LocalTask> updatedLocalTasks,
      List<LocalTask> updatedServerTasks, LocalTask task) {
    updatedLocalTasks.removeWhere((element) => element.id == task.id);
    updatedServerTasks.removeWhere((element) => element.id == task.id);
  }

  // List<LocalTask> _getUpdatedServerTasks(
  //     List<LocalTask> localTasks, List<LocalTask> serverTasks) {
  //   return serverTasks.where((localTask) {
  //     final compareTask = serverTasks.firstWhere(
  //         (serverTask) => serverTask.id == localTask.id,
  //         orElse: () => null);
  //     if (compareTask != null) {
  //       return DateHelper.compareStringTime(
  //               localTask.updatedAt, compareTask.updatedAt) !=
  //           0;
  //     } else {
  //       return true;
  //     }
  //   }).toList();
  // }

  List<LocalTask> _getUpdatedLocalTask(
      List<LocalTask> localTasks, List<LocalTask> serverTasks) {
    return localTasks.where((localTask) {
      final compareTask = serverTasks.firstWhere(
          (serverTask) => serverTask.id == localTask.id,
          orElse: () => null);
      if (compareTask != null) {
        bool isUpdated = DateHelper.compareStringTime(
                localTask.updatedAt, compareTask.updatedAt) >
            0;
        if (isUpdated) {
          log('testAsync isUpdated $localTask : $compareTask');
        }
        return isUpdated;
      } else {
        return true;
      }
    }).toList();
  }

  List<LocalTask> _getEditedTask(
      List<LocalTask> source, List<LocalTask> compare) {
    return source.where((sourceTask) {
      final serverTask = compare.firstWhere(
          (compareTask) => compareTask.id == sourceTask.id,
          orElse: () => null);
      if (serverTask != null) {
        return DateHelper.compareStringTime(
                sourceTask.updatedAt, serverTask.updatedAt) >
            0;
      } else {
        return false;
      }
    }).toList();
  }

  @override
  Future<void> checkServer() async {
    return true;
    final user = await _localUserDataSource.getUser();
    try {
      // await _remoteTaskDataSource.getLabels(user.authorization);
    } catch (e) {
      rethrow;
    }
  }
}
