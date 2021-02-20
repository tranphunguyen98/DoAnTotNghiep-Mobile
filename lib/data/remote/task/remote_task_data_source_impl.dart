import 'package:totodo/data/data_source/task/remote_task_data_source.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/remote/task/remote_task_service.dart';

class RemoteTaskDataSourceImpl implements RemoteTaskDataSource {
  final RemoteTaskService _taskService;

  RemoteTaskDataSourceImpl(this._taskService);

  @override
  Future<bool> addTask(Task task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<Task> getDetailTask(String id) {
    // TODO: implement getDetailTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTask() async {
    return Future.delayed(Duration(seconds: 1), () {
      return [
        Task(id: 1, taskName: "Name Task 1"),
        Task(id: 1, taskName: "Name Task 2"),
        Task(id: 1, taskName: "Name Task 3"),
        Task(id: 1, taskName: "Name Task 4"),
      ];
    });
  }
}
