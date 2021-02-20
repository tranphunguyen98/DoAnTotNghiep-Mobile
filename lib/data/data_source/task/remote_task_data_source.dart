import 'package:totodo/data/entity/task.dart';

abstract class RemoteTaskDataSource {
  Future<bool> addTask(Task task);

  Future<Task> getDetailTask(String id);

  Future<List<Task>> getAllTask();
}
