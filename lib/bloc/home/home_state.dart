import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/section_display.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';
import 'package:totodo/utils/date_helper.dart';

class HomeState extends Equatable {
  static const kDrawerIndexInbox = 0;
  static const kDrawerIndexToday = 1;
  static const kDrawerIndexNextWeek = 2;
  static const kBottomNavigationTask = 0;
  static const kBottomNavigationHabit = 1;
  static const kBottomNavigationSetting = 2;

  // static const kDrawerIndexThisMonth = 3;

  final List<DrawerItemData> drawerItems;
  final int indexDrawerSelected;
  final int indexNavigationBarSelected;
  final List<Task> _listAllTask;
  final List<Project> listProject;
  final List<Label> listLabel;
  final List<SectionDisplay> listSection;
  final bool isShowCompletedTask;
  final bool loading;
  final String msg;

  const HomeState(
      {this.indexDrawerSelected = kDrawerIndexInbox,
      this.indexNavigationBarSelected = kBottomNavigationTask,
      this.isShowCompletedTask = false,
      this.loading,
      this.msg,
      List<Task> listAllTask,
      this.listSection,
      this.drawerItems,
      this.listProject,
      this.listLabel})
      : _listAllTask = listAllTask;

  factory HomeState.loading() {
    return const HomeState(loading: true);
  }

  factory HomeState.error(String msg) {
    return HomeState(msg: msg, loading: false);
  }

  @override
  List<Object> get props => [
        indexDrawerSelected,
        indexNavigationBarSelected,
        isShowCompletedTask,
        _listAllTask,
        loading,
        msg,
        drawerItems,
        listProject,
        listLabel,
        listSection,
      ];

  @override
  String toString() {
    return 'HomeState{drawerItems: $drawerItems, indexDrawerSelected: $indexDrawerSelected, indexNavigationBarSelected: $indexNavigationBarSelected, _listAllTask: $_listAllTask, listProject: $listProject, listLabel: $listLabel, listSection: $listSection, isShowCompletedTask: $isShowCompletedTask, loading: $loading, msg: $msg}';
  }

  HomeState copyWith({
    List<DrawerItemData> drawerItems,
    int indexDrawerSelected,
    int indexNavigationBarSelected,
    List<Task> listAllTask,
    List<Project> listProject,
    List<Label> listLabel,
    List<SectionDisplay> listSection,
    bool isShowCompletedTask,
    bool loading,
    String msg,
  }) {
    if ((drawerItems == null || identical(drawerItems, this.drawerItems)) &&
        (indexDrawerSelected == null ||
            identical(indexDrawerSelected, this.indexDrawerSelected)) &&
        (indexNavigationBarSelected == null ||
            identical(
                indexNavigationBarSelected, this.indexNavigationBarSelected)) &&
        (listAllTask == null || identical(listAllTask, this._listAllTask)) &&
        (listProject == null || identical(listProject, this.listProject)) &&
        (listLabel == null || identical(listLabel, this.listLabel)) &&
        (listSection == null || identical(listSection, this.listSection)) &&
        (isShowCompletedTask == null ||
            identical(isShowCompletedTask, this.isShowCompletedTask)) &&
        (loading == null || identical(loading, this.loading)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return HomeState(
      drawerItems: drawerItems ?? this.drawerItems,
      indexDrawerSelected: indexDrawerSelected ?? this.indexDrawerSelected,
      indexNavigationBarSelected:
          indexNavigationBarSelected ?? this.indexNavigationBarSelected,
      listAllTask: listAllTask ?? _listAllTask,
      listProject: listProject ?? this.listProject,
      listLabel: listLabel ?? this.listLabel,
      listSection: listSection ?? this.listSection,
      isShowCompletedTask: isShowCompletedTask ?? this.isShowCompletedTask,
      loading: loading ?? this.loading,
      msg: msg ?? this.msg,
    );
  }

  List<SectionDisplay> listSectionDataDisplay() {
    List<SectionDisplay> listSection = <SectionDisplay>[];
    if (_listAllTask == null) return listSection;

    if (indexDrawerSelected == kDrawerIndexInbox) {
      listSection = _getListSectionInbox();
    } else if (indexDrawerSelected == kDrawerIndexToday) {
      listSection = _getListSectionToday();
    } else if (indexDrawerSelected == kDrawerIndexNextWeek) {
      listSection = _getListSectionNextWeek();
    } else if (drawerItems[indexDrawerSelected].type ==
        DrawerItemData.kTypeProject) {
      listSection = _getListSectionProject();
    } else if (drawerItems[indexDrawerSelected].type ==
        DrawerItemData.kTypeLabel) {
      listSection = _getListSectionLabel();
    } else if (drawerItems[indexDrawerSelected].type ==
        DrawerItemData.kTypeFilter) {
      listSection = _getListSectionFilter();
    }

    SectionDisplay completedSection;
    if (isShowCompletedTask) {
      completedSection = _getCompletedSection(listSection);
    }

    for (final section in listSection) {
      section.listTask.removeWhere((task) => task.isCompleted);
    }

    if (completedSection != null) {
      listSection.add(completedSection);
    }

    listSection.removeWhere(
        (section) => !section.isShowIfEmpty && section.listTask.isEmpty);

    _sortListTask(listSection);

    // log('listSection', listSection);

    return listSection;
  }

  bool isInProject() {
    if (drawerItems != null) {
      return drawerItems[indexDrawerSelected].type ==
          DrawerItemData.kTypeProject;
    }
    return false;
  }

  Project getProjectSelected() {
    if (isInProject()) {
      return drawerItems[indexDrawerSelected].data as Project;
    }
    throw Exception('Not in project screen');
  }

  List<SectionDisplay> _getListSectionWithDataAndConditionDate(
      List<SectionDisplay> listSectionNoData) {
    final listSectionWithData = listSectionNoData.map((section) {
      final listTaskWithSection = _listAllTask.where((task) {
        return !(task.taskDate?.isEmpty ?? true) &&
            section.dateCondition(task.taskDate);
      }).toList();
      return section.copyWith(listTask: listTaskWithSection);
    }).toList();

    return listSectionWithData;
  }

  List<SectionDisplay> _getListSectionWithDataAndConditionSection(
      List<SectionDisplay> listSectionNoData) {
    final listSectionWithData = listSectionNoData.map((section) {
      final listTaskWithSection = _listAllTask.where((task) {
        return !(task.sectionId?.isEmpty ?? true) &&
            section.dateCondition(task.sectionId);
      }).toList();
      return section.copyWith(listTask: listTaskWithSection);
    }).toList();
    return listSectionWithData;
  }

  List<SectionDisplay> _getListSectionInbox() {
    final inboxTaskList = _listAllTask
        .where((task) => task.project?.id?.isEmpty ?? true)
        .toList();

    final List<SectionDisplay> listSection = [];

    if (inboxTaskList.isNotEmpty) {
      listSection
          .add(SectionDisplay.kSectionNoName.copyWith(listTask: inboxTaskList));
    }

    return listSection;
  }

  List<SectionDisplay> _getListSectionToday() {
    final listSectionNoData = [
      SectionDisplay.kSectionOverdue,
      SectionDisplay.kSectionToday,
    ];

    final listSectionWithData =
        _getListSectionWithDataAndConditionDate(listSectionNoData);

    /// listSectionWithData[0]: Overdue
    /// listSectionWithData[1]: Today
    if (listSectionWithData[0].listTask.isEmpty &&
        listSectionWithData[1].listTask.isEmpty) {
      return [];
    }

    listSectionWithData.removeWhere((element) => element.listTask.isEmpty);

    return listSectionWithData;
  }

  List<SectionDisplay> _getListSectionNextWeek() {
    final listSectionNoData = [
      SectionDisplay.kSectionOverdue,
      SectionDisplay.kSectionToday.copyWith(isShowIfEmpty: true),
      SectionDisplay.kSectionTomorrow,
      ...[2, 3, 4, 5, 6]
          .map(
            (numberOfDay) => SectionDisplay(
                id: DateHelper.getNameOfDay(
                    DateTime.now().add(Duration(days: numberOfDay))),
                name: DateHelper.getNameOfDay(
                    DateTime.now().add(Duration(days: numberOfDay))),
                dateCondition: (dateTime) {
                  return DateHelper.isAfterNumberDay(
                      DateTime.parse(dateTime), numberOfDay);
                }),
          )
          .toList(),
    ];

    return _getListSectionWithDataAndConditionDate(listSectionNoData);
  }

  List<SectionDisplay> _getListSectionProject() {
    final List<SectionDisplay> listSectionWithTaskHaveSection =
        _getListSectionWithTaskHaveSection();

    final List<Task> listTaskNoSection = _getListTaskNoSection();

    if (listSectionWithTaskHaveSection.isEmpty && listTaskNoSection.isEmpty) {
      return [];
    }

    final listSectionOfProject = <SectionDisplay>[];

    if (listTaskNoSection.isNotEmpty) {
      listSectionOfProject.add(
          SectionDisplay.kSectionNoName.copyWith(listTask: listTaskNoSection));
    }

    listSectionOfProject.addAll(listSectionWithTaskHaveSection);

    return listSectionOfProject;
  }

  List<SectionDisplay> _getListSectionLabel() {
    final listTask = _listAllTask.where((element) {
      if (element.labels?.isEmpty ?? true) {
        return false;
      }

      return element.labels
          .contains(drawerItems[indexDrawerSelected].data as Label);
    }).toList();

    if (listTask.isNotEmpty) {
      return [SectionDisplay.kSectionNoName.copyWith(listTask: listTask)];
    }

    return [];
  }

  List<Task> _getListTaskNoSection() {
    // listTask with no section
    final listTaskNoSection = _listAllTask.where((element) {
      if (element.project == null) {
        return false;
      }
      return element.project?.id ==
              (drawerItems[indexDrawerSelected].data as Project).id &&
          (element.sectionId?.isEmpty ?? true);
    }).toList();
    return listTaskNoSection;
  }

  List<SectionDisplay> _getListSectionWithTaskHaveSection() {
    final projectSelected = drawerItems[indexDrawerSelected].data as Project;

    final listSectionWithProject =
        listSection.where((element) => element.projectId == projectSelected.id);

    //Add condition date to listSection
    final listSectionWithCondition = listSectionWithProject
        .map((section) => section.copyWith(dateCondition: (value) {
              return value == section.id;
            }))
        .toList();

    //Add data to listSection
    final listSectionWithData =
        _getListSectionWithDataAndConditionSection(listSectionWithCondition);
    return listSectionWithData;
  }

  List<SectionDisplay> _getListSectionFilter() {
    final listTask = _listAllTask.where((task) {
      return task.priority == drawerItems[indexDrawerSelected].data as int;
    }).toList();

    if (listTask.isNotEmpty) {
      return [SectionDisplay.kSectionNoName.copyWith(listTask: listTask)];
    }

    return [];
  }

  void _sortListTask(List<SectionDisplay> sections) {
    for (final section in sections) {
      section.listTask.sort((task1, task2) {
        final bool isBothNoDay = (task1.taskDate?.isEmpty ?? true) &&
            (task2.taskDate?.isEmpty ?? true);

        final bool isSameDay = (!(task1.taskDate?.isEmpty ?? true) &&
                !(task2.taskDate?.isEmpty ?? true)) &&
            DateHelper.isSameDayString(task1.taskDate, task2.taskDate);

        if (isBothNoDay || isSameDay) {
          return task1.priority.compareTo(task2.priority);
        } else {
          if (task1.taskDate?.isEmpty ?? true) {
            return 1;
          }
          if (task2.taskDate?.isEmpty ?? true) {
            return -1;
          }
          return DateHelper.compareStringDay(task1.taskDate, task2.taskDate);
        }
      });
    }
  }

  SectionDisplay _getCompletedSection(List<SectionDisplay> sections) {
    final List<Task> completedTasks = [];

    for (final section in sections) {
      completedTasks
          .addAll(section.listTask.where((task) => task.isCompleted).toList());
    }
    if (completedTasks.isNotEmpty) {
      return SectionDisplay.kSectionCompleted
          .copyWith(listTask: completedTasks);
    }
    return null;
  }
}
