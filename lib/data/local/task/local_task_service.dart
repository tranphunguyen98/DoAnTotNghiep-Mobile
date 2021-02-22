import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';

@Injectable()
class LocalTaskService {
  static const kNameBoxTask = "task";
  static const kNameBoxProject = "project";

  Box _taskBoxTask;
  Box _taskBoxProject;

  LocalTaskService() {
    _taskBoxTask = Hive.box(kNameBoxTask);
    _taskBoxProject = Hive.box(kNameBoxProject);
  }

  Future<bool> addTask(Task task) async {
    if (task.id == null) {
      _taskBoxTask.add(
          task.copyWith(id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    }
    _taskBoxTask.add(task);
    return true;
  }

  Future<bool> addProject(Project project) async {
    if (project.id == null) {
      _taskBoxProject.add(project.copyWith(
          id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    }
    _taskBoxProject.add(project);
    return true;
  }

  Future<List<Task>> getAllTask() async {
    final listTask = <Task>[];
    for (var i = 0; i < _taskBoxTask.length; i++) {
      listTask.add(_taskBoxTask.getAt(i) as Task);
    }
    print("LIST TASK: ${listTask}");
    return listTask ?? <Task>[];
  }

  Future<List<Project>> getProjects() async {
    final listProject = <Project>[];
    for (var i = 0; i < _taskBoxProject.length; i++) {
      listProject.add(_taskBoxProject.getAt(i) as Project);
    }
    print("LIST PROJECT: ${listProject}");
    return listProject ?? <Project>[];
  }

  bool updateTask(Task task) {
    int indexUpdated = -1;
    for (var i = 0; i < _taskBoxTask.length; i++) {
      if ((_taskBoxTask.getAt(i) as Task).id == task.id) {
        indexUpdated = i;
        break;
      }
    }
    if (indexUpdated > -1) {
      _taskBoxTask.putAt(indexUpdated, task);
      return true;
    }
    return false;
  }
}
