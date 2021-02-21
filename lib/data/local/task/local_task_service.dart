import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:totodo/data/entity/task.dart';

@Injectable()
class LocalTaskService {
  static const kNameBoxTask = "task";
  Box _taskBox;
  LocalTaskService() {
    _taskBox = Hive.box(kNameBoxTask);
  }

  Future<bool> addTask(Task task) async {
    if (task.id == null) {
      _taskBox.add(task.copyWith(id: DateTime.now().microsecondsSinceEpoch));
      return true;
    }
    _taskBox.add(task);
    return true;
  }

  Future<List<Task>> getAllTask() async {
    // _taskBox.clear();
    final listTask = <Task>[];
    for (var i = 0; i < _taskBox.length; i++) {
      listTask.add(_taskBox.getAt(i) as Task);
    }
    print("LIST TASK: ${listTask}");
    return listTask as List<Task> ?? [];
  }

  bool updateTask(Task task) {
    int indexUpdated = -1;
    for (var i = 0; i < _taskBox.length; i++) {
      if ((_taskBox.getAt(i) as Task).id == task.id) {
        indexUpdated = i;
        break;
      }
    }
    if (indexUpdated > -1) {
      _taskBox.putAt(indexUpdated, task);
      return true;
    }
    return false;
  }
}
