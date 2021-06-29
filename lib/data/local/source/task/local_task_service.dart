import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:objectid/objectid.dart';
import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/model/section.dart';
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
  Future<String> addTask(LocalTask localTask) async {
    final task = await getTaskFromId(localTask.id);
    if (task != null) {
      log('GlobalKeyTest', 'duplicate $localTask.id $task');
      return null;
    }

    final currentDateString = DateTime.now().toIso8601String();
    if (localTask.id == null) {
      final taskWithId = localTask.copyWith(
        id: ObjectId().hexString,
        isOnlyCreatedOnLocal: true,
        createdAt: currentDateString,
        updatedAt: currentDateString,
      );
      _taskBox.add(taskWithId);
      return taskWithId.id;
    } else {
      _taskBox.add(localTask.copyWith(
        createdAt: localTask.createdAt ?? currentDateString,
        updatedAt: localTask.updatedAt ?? currentDateString,
      ));
    }

    return localTask.id;
  }

  Future<List<LocalTask>> getAllTask() async {
    final listTask = <LocalTask>[];
    for (var i = 0; i < _taskBox.length; i++) {
      listTask.add(_taskBox.getAt(i) as LocalTask);
    }

    log("testLocal1111111", listTask.length);

    return listTask ?? <LocalTask>[];
  }

  Future<LocalTask> getTaskFromId(String idTask) async {
    final task = await _taskBox.values.firstWhere(
        (element) => (element as LocalTask).id == idTask,
        orElse: () => null);
    if (task != null) {
      return task as LocalTask;
    }
    return null;
  }

  bool updateTask(LocalTask localTask) {
    int indexUpdated = -1;

    for (var i = 0; i < _taskBox.length; i++) {
      if ((_taskBox.getAt(i) as LocalTask).id == localTask.id) {
        indexUpdated = i;
        break;
      }
    }

    if (indexUpdated > -1) {
      _taskBox.putAt(indexUpdated,
          localTask.copyWith(updatedAt: DateTime.now().toIso8601String()));
      return true;
    }
    return false;
  }

  bool updateTaskAsync(LocalTask localTask) {
    int indexUpdated = -1;

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

  Future<void> permanentlyDeleteTask(String taskId) async {
    int indexUpdated = -1;

    for (var i = 0; i < _taskBox.length; i++) {
      if ((_taskBox.getAt(i) as LocalTask).id == taskId) {
        indexUpdated = i;
        break;
      }
    }

    if (indexUpdated > -1) {
      _taskBox.deleteAt(indexUpdated);
    }
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
    // log("testLocal1111111", listProject);
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

  Future<void> deleteProject(String projectId) async {
    int indexUpdated = -1;

    for (var i = 0; i < _projectBox.length; i++) {
      if ((_projectBox.getAt(i) as Project).id == projectId) {
        indexUpdated = i;
        break;
      }
    }

    if (indexUpdated > -1) {
      _projectBox.deleteAt(indexUpdated);
    }
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
    log("LIST LABEL: $listLabel");
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
    sections.addAll(project?.sections ?? []);

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
