import 'package:totodo/data/data_source/task/local_task_data_source.dart';
import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/model/section.dart';

import 'local_task_service.dart';

class LocalTaskDataSourceImplement implements LocalTaskDataSource {
  final LocalTaskService _taskService;

  const LocalTaskDataSourceImplement(this._taskService);

  @override
  Future<String> addTask(LocalTask task) => _taskService.addTask(task);

  @override
  Future<LocalTask> getDetailTask(String id) {
    return _taskService.getTaskFromId(id);
  }

  @override
  Future<List<LocalTask>> getAllTask() async {
    return _taskService.getAllTask();
  }

  @override
  Future<bool> updateTask(LocalTask task) async {
    return _taskService.updateTask(task);
  }

  @override
  Future<bool> updateTaskAsync(LocalTask task) async {
    return _taskService.updateTaskAsync(task);
  }

  @override
  Future<void> addProject(Project project) {
    return _taskService.addProject(project);
  }

  @override
  Future<void> updateProject(Project project) {
    return _taskService.updateProject(project);
  }

  @override
  Future<List<Project>> getProjects() {
    return _taskService.getProjects();
  }

  @override
  Future<void> addLabel(Label label) {
    return _taskService.addLabel(label);
  }

  @override
  Future<List<Label>> getLabels() {
    return _taskService.getLabels();
  }

  @override
  Future<void> updateLabel(Label label) {
    return _taskService.updateLabel(label);
  }

  // @override
  // Future<void> addSection(SectionDisplay section) {
  //   return _taskService.addSection(section);
  // }
  //
  // @override
  // Future<List<SectionDisplay>> getSections() {
  //   return _taskService.getAllSection();
  // }
  //
  // @override
  // Future<void> updateSection(SectionDisplay section) {
  //   throw UnimplementedError();
  // }

  @override
  Future<void> clearData() {
    //TODO Clear images
    return _taskService.clearData();
  }

  @override
  Future<void> saveProjects(List<Project> projects) {
    return _taskService.saveProjects(projects);
  }

  @override
  Future<void> saveTasks(List<LocalTask> tasks) {
    return _taskService.saveTasks(tasks);
  }

  @override
  Future<void> saveLabels(List<Label> labels) {
    return _taskService.saveLabels(labels);
  }

  @override
  Future<void> addSection(String projectId, Section section) {
    return _taskService.addSection(projectId, section);
  }

  @override
  Future<void> deleteSection(String projectId, String sectionId) {
    return _taskService.deleteSection(projectId, sectionId);
  }

  @override
  Future<void> updateSection(String projectId, Section section) {
    return _taskService.updateSection(projectId, section);
  }

  @override
  Future<void> deleteLabel(String labelId) {
    return _taskService.deleteLabel(labelId);
  }

  @override
  Future<void> deleteProject(String projectId) {
    return _taskService.deleteProject(projectId);
  }

  @override
  Future<void> deletePermenantlyTask(String taskId) {
    return _taskService.permanentlyDeleteTask(taskId);
  }
}
