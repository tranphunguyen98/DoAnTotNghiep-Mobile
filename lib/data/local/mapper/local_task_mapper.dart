import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/local/model/local_task.dart';

class LocalTaskMapper {
  List<Project> listProject;
  List<Label> listLabel;

  LocalTaskMapper({this.listLabel, this.listProject});

  Task mapFromLocal(LocalTask localTask) {
    return Task(
      id: localTask.id,
      name: localTask.name,
      taskDate: localTask.taskDate,
      createdDate: localTask.createdDate,
      updatedDate: localTask.updatedDate,
      description: localTask.description,
      isCompleted: localTask.isCompleted,
      isStarred: localTask.isStarred,
      isTrashed: localTask.isTrashed,
      priorityType: localTask.priorityType,
      project: localTask.projectId?.isEmpty ?? true
          ? null
          : getProjectFromId(localTask.projectId),
      labels: localTask.labelIds?.isEmpty ?? true
          ? <Label>[]
          : getListLabelFromListId(localTask.labelIds),
    );
  }

  LocalTask mapToLocal(Task task) {
    print("labelsID ${task.labels?.map((e) => e.id)?.toList()}");
    return LocalTask(
      id: task.id,
      name: task.name,
      taskDate: task.taskDate,
      createdDate: task.createdDate,
      updatedDate: task.updatedDate,
      description: task.description,
      isCompleted: task.isCompleted,
      isStarred: task.isStarred,
      isTrashed: task.isTrashed,
      priorityType: task.priorityType,
      projectId: task.project?.id,
      labelIds: task.labels?.map((e) => e.id)?.toList(),
    );
  }

  Project getProjectFromId(String id) {
    print("id: $id");
    return listProject.firstWhere((element) => element.id == id);
  }

  List<Label> getListLabelFromListId(List<String> labelIds) {
    print("labelIds $labelIds");
    final listLabel1 =
        listLabel.where((element) => labelIds.contains(element.id)).toList();
    print("listLabel1 $listLabel1");
    return listLabel1;
  }
}
