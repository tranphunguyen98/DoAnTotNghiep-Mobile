import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/model/task.dart';
import 'package:totodo/data/local/model/local_task.dart';

class LocalTaskMapper {
  List<Project> listProject;
  List<Label> listLabel;

  LocalTaskMapper({
    this.listLabel,
    this.listProject,
  });

  Task mapFromLocal(LocalTask localTask) {
    return Task(
      id: localTask.id,
      name: localTask.name,
      taskDate: localTask.dueDate,
      createdAt: localTask.createdAt,
      updatedAt: localTask.updatedAt,
      description: localTask.description,
      isCompleted: localTask.isCompleted,
      isStarred: localTask.isStarred,
      isTrashed: localTask.isTrashed,
      isCreatedOnLocal: localTask.isCreatedOnLocal,
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
        createdAt: task.createdAt,
        updatedAt: task.updatedAt,
        description: task.description,
        isCompleted: task.isCompleted,
        isStarred: task.isStarred,
        isTrashed: task.isTrashed,
        isCreatedOnLocal: task.isCreatedOnLocal,
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
    // log('idProjectTest', id);
    return listProject.firstWhere((element) => element.id == id,
        orElse: () => null);
  }

  List<Label> getListLabelFromListId(List<String> labelIds) {
    final listLabel1 =
        listLabel.where((element) => labelIds.contains(element.id)).toList();
    return listLabel1;
  }
}
