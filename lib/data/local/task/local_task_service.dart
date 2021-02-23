import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';

@Injectable()
class LocalTaskService {
  static const kNameBoxTask = "task";
  static const kNameBoxProject = "project";
  static const kNameBoxLabel = "label";

  Box _taskBoxTask;
  Box _taskBoxProject;
  Box _taskBoxLabel;

  LocalTaskService() {
    _taskBoxTask = Hive.box(kNameBoxTask);
    _taskBoxProject = Hive.box(kNameBoxProject);
    _taskBoxLabel = Hive.box(kNameBoxLabel);
  }

  //<editor-fold desc="Task" defaultstate="collapsed">
  Future<bool> addTask(Task task) async {
    if (task.id == null) {
      _taskBoxTask.add(
          task.copyWith(id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    }
    _taskBoxTask.add(task);
    return true;
  }

  Future<List<Task>> getAllTask() async {
    // _taskBoxTask.clear();
    final listTask = <Task>[];
    for (var i = 0; i < _taskBoxTask.length; i++) {
      listTask.add(_taskBoxTask.getAt(i) as Task);
    }
    print("LIST TASK: ${listTask}");
    return listTask ?? <Task>[];
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

  //</editor-fold>

  //<editor-fold desc="Project" defaultstate="collapsed">
  Future<bool> addProject(Project project) async {
    if (project.id == null) {
      _taskBoxProject.add(project.copyWith(
          id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    }
    _taskBoxProject.add(project);
    return true;
  }

  Future<List<Project>> getProjects() async {
    final listProject = <Project>[];
    for (var i = 0; i < _taskBoxProject.length; i++) {
      listProject.add(_taskBoxProject.getAt(i) as Project);
    }
    //print("LIST PROJECT: ${listProject}");
    return listProject ?? <Project>[];
  }

  //</editor-fold>

  //<editor-fold desc="Label" defaultstate="collapsed">
  Future<bool> addLabel(Label label) async {
    if (label.id == null) {
      _taskBoxLabel.add(
          label.copyWith(id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    }
    _taskBoxLabel.add(label);
    return true;
  }

  Future<List<Label>> getLabels() async {
    final listLabel = <Label>[];
    for (var i = 0; i < _taskBoxLabel.length; i++) {
      listLabel.add(_taskBoxLabel.getAt(i) as Label);
    }
    print("LIST LABEL: ${listLabel}");
    return listLabel ?? <Label>[];
  }

  //</editor-fold>
}
