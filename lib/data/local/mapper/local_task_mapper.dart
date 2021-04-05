import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/local/model/local_task.dart';

class LocalTaskMapper {
  List<Project> listProject;
  List<Label> listLabel;
  List<Section> listSection;

  LocalTaskMapper(
      {this.listLabel, this.listProject, this.listSection = const []});

  Task mapFromLocal(LocalTask localTask) {
    return Task(
      id: localTask.id,
      name: localTask.name,
      taskDate: localTask.dueDate,
      createdDate: localTask.createdDate,
      updatedDate: localTask.updatedDate,
      description: localTask.description,
      isCompleted: localTask.isCompleted,
      isStarred: localTask.isStarred,
      isTrashed: localTask.isTrashed,
      priority: localTask.priority,
      completedDate: localTask.completedDate,
      crontabSchedule: localTask.crontabSchedule,
      preciseSchedules: localTask.preciseSchedules,
      project: localTask.projectId?.isEmpty ?? true
          ? null
          : getProjectFromId(localTask.projectId),
      sectionId: localTask.sectionId,
      labels: localTask.labelIds?.isEmpty ?? true
          ? <Label>[]
          : getListLabelFromListId(localTask.labelIds),
      checkList: localTask.checkList,
    );
  }

  LocalTask mapToLocal(Task task) {
    return LocalTask(
        id: task.id,
        name: task.name,
        dueDate: task.taskDate,
        createdDate: task.createdDate,
        updatedDate: task.updatedDate,
        description: task.description,
        isCompleted: task.isCompleted,
        isStarred: task.isStarred,
        isTrashed: task.isTrashed,
        priority: task.priority,
        projectId: task.project?.id,
        sectionId: task.sectionId,
        preciseSchedules: task.preciseSchedules,
        crontabSchedule: task.crontabSchedule,
        completedDate:
            task.completedDate?.isNotEmpty ?? true ? null : task.completedDate,
        labelIds: task.labels?.map((e) => e.id)?.toList(),
        checkList: task.checkList);
  }

  Project getProjectFromId(String id) {
    return listProject.firstWhere((element) => element.id == id);
  }

  List<Label> getListLabelFromListId(List<String> labelIds) {
    final listLabel1 =
        listLabel.where((element) => labelIds.contains(element.id)).toList();
    return listLabel1;
  }
}
