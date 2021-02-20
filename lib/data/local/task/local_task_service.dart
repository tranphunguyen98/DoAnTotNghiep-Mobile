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
    _taskBox.add(task);
    return true;
  }

  Future<List<Task>> getAllTask() async {
    final listTask = <Task>[];
    for (var i = 0; i < _taskBox.length; i++) {
      listTask.add(_taskBox.getAt(i) as Task);
    }
    print("LIST TASK: ${listTask}");
    return listTask as List<Task> ?? [];
  }
}
