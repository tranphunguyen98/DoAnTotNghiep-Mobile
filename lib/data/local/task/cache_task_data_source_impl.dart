import 'package:totodo/data/data_source/task/local_task_data_source.dart';
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
}
