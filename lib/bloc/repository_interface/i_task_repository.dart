import 'package:totodo/data/entity/task.dart';

abstract class ITaskRepository {
  Future<bool> addTask(Task task);
  Future<Task> getDetailTask(String id);
  Future<List<Task>> getAllTask();
  Future<bool> updateTask(Task task);
}
