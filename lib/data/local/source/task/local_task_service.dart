import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/local/mapper/local_task_mapper.dart';
import 'package:totodo/data/local/model/local_task.dart';

@Injectable()
class LocalTaskService {
  static const kNameBoxTask = "task";
  static const kNameBoxProject = "project";
  static const kNameBoxLabel = "label";
  static const kNameBoxSection = "section";

  Box _taskBoxTask;
  Box _taskBoxProject;
  Box _taskBoxLabel;
  Box _taskBoxSection;

  LocalTaskService() {
    _taskBoxTask = Hive.box(kNameBoxTask);
    _taskBoxProject = Hive.box(kNameBoxProject);
    _taskBoxLabel = Hive.box(kNameBoxLabel);
    _taskBoxSection = Hive.box(kNameBoxSection);
  }

  //<editor-fold desc="Task" defaultstate="collapsed">
  Future<bool> addTask(Task task) async {
    final localTask = LocalTaskMapper().mapToLocal(task);

    if (localTask.id == null) {
      _taskBoxTask.add(localTask.copyWith(
          id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    }
    _taskBoxTask.add(localTask);
    return true;
  }

  Future<List<Task>> getAllTask() async {
    final localTaskMapper = LocalTaskMapper(
        listLabel: await getLabels(), listProject: await getProjects());

    final listTask = <Task>[];
    for (var i = 0; i < _taskBoxTask.length; i++) {
      listTask.add(
          localTaskMapper.mapFromLocal(_taskBoxTask.getAt(i) as LocalTask));
    }
    print("LIST TASK: ${listTask}");
    return listTask ?? <Task>[];
  }

  bool updateTask(Task task) {
    int indexUpdated = -1;

    final localTask = LocalTaskMapper().mapToLocal(task);

    for (var i = 0; i < _taskBoxTask.length; i++) {
      if ((_taskBoxTask.getAt(i) as LocalTask).id == localTask.id) {
        indexUpdated = i;
        break;
      }
    }
    if (indexUpdated > -1) {
      _taskBoxTask.putAt(indexUpdated, localTask);
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
    print("LIST PROJECT: ${listProject}");
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

  //<editor-fold desc="Section" defaultstate="collapsed">
  Future<bool> addSection(Section section) async {
    if (section.id == null) {
      _taskBoxSection.add(section.copyWith(
          id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    }
    _taskBoxSection.add(section);
    return true;
  }

  Future<List<Section>> getAllSection() async {
    final listSection = <Section>[];
    for (var i = 0; i < _taskBoxSection.length; i++) {
      listSection.add(_taskBoxSection.getAt(i) as Section);
    }
    print("LIST SECTION: $listSection");
    return listSection ?? <Section>[];
  }

  bool updateSection(Section section) {
    int indexUpdated = -1;

    for (var i = 0; i < _taskBoxSection.length; i++) {
      if ((_taskBoxSection.getAt(i) as Section).id == section.id) {
        indexUpdated = i;
        break;
      }
    }

    if (indexUpdated > -1) {
      _taskBoxSection.putAt(indexUpdated, section);
      return true;
    }

    return false;
  }

//</editor-fold>
}
