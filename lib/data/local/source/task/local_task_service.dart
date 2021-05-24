import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/local/mapper/local_task_mapper.dart';
import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/utils/util.dart';

@Injectable()
class LocalTaskService {
  static const kNameBoxTask = "task";
  static const kNameBoxProject = "project";
  static const kNameBoxLabel = "label";

  Box _taskBox;
  Box _projectBox;
  Box _labelBox;

  LocalTaskService() {
    _taskBox = Hive.box(kNameBoxTask);
    _projectBox = Hive.box(kNameBoxProject);
    _labelBox = Hive.box(kNameBoxLabel);
  }

  //<editor-fold desc="Task" defaultstate="collapsed">
  Future<bool> addTask(LocalTask localTask) async {
    if (localTask.id == null) {
      _taskBox.add(localTask.copyWith(
          id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    }

    _taskBox.add(localTask);
    return true;
  }

  Future<List<Task>> getAllTask() async {
    final localTaskMapper = LocalTaskMapper(
        listLabel: await getLabels(), listProject: await getProjects());

    final listTask = <Task>[];
    for (var i = 0; i < _taskBox.length; i++) {
      listTask
          .add(localTaskMapper.mapFromLocal(_taskBox.getAt(i) as LocalTask));
    }
    log("testLocal1111111", listTask);

    return listTask ?? <Task>[];
  }

  Future<Task> getTaskFromId(String idTask) async {
    final localTaskMapper = LocalTaskMapper(
        listLabel: await getLabels(), listProject: await getProjects());

    final task = await _taskBox.values
            .firstWhere((element) => (element as LocalTask).id == idTask)
        as LocalTask;

    return localTaskMapper.mapFromLocal(task);
  }

  bool updateTask(Task task) {
    int indexUpdated = -1;

    final localTask = LocalTaskMapper().mapToLocal(task);

    for (var i = 0; i < _taskBox.length; i++) {
      if ((_taskBox.getAt(i) as LocalTask).id == localTask.id) {
        indexUpdated = i;
        break;
      }
    }
    if (indexUpdated > -1) {
      _taskBox.putAt(indexUpdated, localTask);
      return true;
    }
    return false;
  }

  Future<void> saveTasks(List<LocalTask> tasks) async {
    await _taskBox.clear();
    await _taskBox.addAll(tasks);
  }

  //</editor-fold>

  //<editor-fold desc="Project" defaultstate="collapsed">
  Future<bool> addProject(Project project) async {
    if (project.id == null) {
      _projectBox.add(
        project.copyWith(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            isLocal: true),
      );
      return true;
    }
    _projectBox.add(project);
    return true;
  }

  Future<Project> getProjectById(String id) async {
    final listProject = await getProjects();
    return listProject.firstWhere((project) => project.id == id);
  }

  Future<List<Project>> getProjects() async {
    final listProject = <Project>[];
    for (var i = 0; i < _projectBox.length; i++) {
      listProject.add(_projectBox.getAt(i) as Project);
    }
    log("testLocal1111111", listProject);
    return listProject ?? <Project>[];
  }

  Future<void> updateProject(Project project) async {
    int indexUpdated = -1;

    for (var i = 0; i < _projectBox.length; i++) {
      if ((_projectBox.getAt(i) as Project).id == project.id) {
        indexUpdated = i;
        break;
      }
    }
    if (indexUpdated > -1) {
      _projectBox.putAt(indexUpdated, project);
    }
  }

  Future<void> saveProjects(List<Project> projects) async {
    await _projectBox.clear();
    await _projectBox.addAll(projects);
  }

  //</editor-fold>

  //<editor-fold desc="Label" defaultstate="collapsed">
  Future<bool> addLabel(Label label) async {
    if (label.id == null) {
      _labelBox.add(
          label.copyWith(id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    }
    _labelBox.add(label);
    return true;
  }

  Future<List<Label>> getLabels() async {
    final listLabel = <Label>[];
    for (var i = 0; i < _labelBox.length; i++) {
      listLabel.add(_labelBox.getAt(i) as Label);
    }
    // print("LIST LABEL: ${listLabel}");
    return listLabel ?? <Label>[];
  }

  Future<void> saveLabels(List<Label> labels) async {
    await _labelBox.clear();
    await _labelBox.addAll(labels);
  }

  Future<void> updateLabel(Label label) async {
    int indexUpdated = -1;

    for (var i = 0; i < _labelBox.length; i++) {
      if ((_labelBox.getAt(i) as Label).id == label.id) {
        indexUpdated = i;
        break;
      }
    }
    if (indexUpdated > -1) {
      _labelBox.putAt(indexUpdated, label);
    }
  }

  Future<void> deleteLabel(String labelId) async {}

  //</editor-fold>

  //<editor-fold desc="Section" defaultstate="collapsed">

  Future<void> addSection(String projectId, Section section) async {
    final Project project = await getProjectById(projectId);

    final List<Section> sections = [];
    sections.addAll(project.sections);

    if (section.id?.isEmpty ?? true) {
      log('local', section);
      sections.add(section.copyWith(
          id: DateTime.now().microsecondsSinceEpoch.toString()));
    } else {
      log('server', section);
      sections.add(section);
    }

    await updateProject(project.copyWith(sections: sections));
  }

  Future<void> updateSection(String projectId, Section section) async {
    final Project project = await getProjectById(projectId);

    final List<Section> sections = [];
    sections.addAll(project.sections);

    int indexUpdate = -1;

    for (int i = 0; i < sections.length; i++) {
      if (sections[i].id == section.id) {
        indexUpdate = i;
        break;
      }
    }

    if (indexUpdate >= 0) {
      sections[indexUpdate] = section;
      await updateProject(project.copyWith(sections: sections));
    }
  }

  Future<void> deleteSection(String projectId, String sectionId) async {
    final Project project = await getProjectById(projectId);

    final List<Section> sections = [];
    sections.addAll(project.sections);
    sections.removeWhere((section) => section.id == sectionId);

    await updateProject(project.copyWith(sections: sections));
  }

//</editor-fold>

  Future<void> clearData() async {
    _taskBox.clear();
    _labelBox.clear();
    _projectBox.clear();
  }
}
