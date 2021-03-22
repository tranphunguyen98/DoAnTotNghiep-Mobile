import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';
import 'package:totodo/utils/date_helper.dart';

class HomeState extends Equatable {
  static const kDrawerIndexInbox = 0;
  static const kDrawerIndexToday = 1;
  static const kDrawerIndexNextWeek = 2;

  // static const kDrawerIndexThisMonth = 3;

  final List<DrawerItemData> drawerItems;
  final int indexDrawerSelected;
  final List<Task> _listAllTask;
  final List<Project> listProject;
  final List<Label> listLabel;
  final List<Section> listSection;
  final bool loading;
  final String msg;

  List<Section> listSectionDataDisplay() {
    if (_listAllTask == null) return <Section>[];

    if (indexDrawerSelected == kDrawerIndexInbox) {
      return _getListSectionInbox();
    }

    if (indexDrawerSelected == kDrawerIndexToday) {
      return _getListSectionToday();
    }

    if (indexDrawerSelected == kDrawerIndexNextWeek) {
      return _getListSectionNextWeek();
    }

    if (drawerItems[indexDrawerSelected].type == DrawerItemData.kTypeProject) {
      return _getListSectionProject();
    }

    if (drawerItems[indexDrawerSelected].type == DrawerItemData.kTypeLabel) {
      return _getListSectionLabel();
    }

    if (drawerItems[indexDrawerSelected].type == DrawerItemData.kTypeFilter) {
      return _getListSectionFilter();
    }

    return <Section>[];
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

  const HomeState(
      {this.indexDrawerSelected = kDrawerIndexInbox,
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
    return 'HomeState{drawerItems: $drawerItems, indexDrawerSelected: $indexDrawerSelected, listProject: $listProject, listLabel: $listLabel, listSection: $listSection, loading: $loading, msg: $msg}';
  }

  HomeState copyWith({
    List<DrawerItemData> drawerItems,
    int indexDrawerSelected,
    List<Task> listAllTask,
    List<Project> listProject,
    List<Label> listLabel,
    List<Section> listSection,
    bool loading,
    String msg,
  }) {
    if ((drawerItems == null || identical(drawerItems, this.drawerItems)) &&
        (indexDrawerSelected == null ||
            identical(indexDrawerSelected, this.indexDrawerSelected)) &&
        (listAllTask == null || identical(listAllTask, _listAllTask)) &&
        (listProject == null || identical(listProject, this.listProject)) &&
        (listLabel == null || identical(listLabel, this.listLabel)) &&
        (listSection == null || identical(listSection, this.listSection)) &&
        (loading == null || identical(loading, this.loading)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return HomeState(
      drawerItems: drawerItems ?? this.drawerItems,
      indexDrawerSelected: indexDrawerSelected ?? this.indexDrawerSelected,
      listAllTask: listAllTask ?? _listAllTask,
      listProject: listProject ?? this.listProject,
      listLabel: listLabel ?? this.listLabel,
      listSection: listSection ?? this.listSection,
      loading: loading ?? this.loading,
      msg: msg ?? this.msg,
    );
  }

  List<Section> _getListSectionWithDataAndConditionDate(
      List<Section> listSectionNoData) {
    final listSectionWithData = listSectionNoData.map((section) {
      final listTaskWithSection = _listAllTask
          .where((task) =>
              !(task.taskDate?.isEmpty ?? true) &&
              section.condition(task.taskDate))
          .toList();
      return section.copyWith(listTask: listTaskWithSection);
    }).toList();
    return listSectionWithData;
  }

  List<Section> _getListSectionWithDataAndConditionSection(
      List<Section> listSectionNoData) {
    final listSectionWithData = listSectionNoData.map((section) {
      final listTaskWithSection = _listAllTask
          .where((task) =>
              !(task.sectionId?.isEmpty ?? true) &&
              section.condition(task.sectionId))
          .toList();
      return section.copyWith(listTask: listTaskWithSection);
    }).toList();
    return listSectionWithData;
  }

  List<Section> _getListSectionInbox() {
    final listTaskInbox = _listAllTask
        .where((element) => element.project?.id?.isEmpty ?? true)
        .toList();

    if (listTaskInbox.isNotEmpty) {
      return [Section.kSectionNoName.copyWith(listTask: listTaskInbox)];
    }
    return [];
  }

  List<Section> _getListSectionToday() {
    final listSectionNoData = [Section.kSectionOverdue, Section.kSectionToday];

    final listSectionWithData =
        _getListSectionWithDataAndConditionDate(listSectionNoData);

    /// listSectionWithData[0]: Overdue
    /// listSectionWithData[1]: Today
    if (listSectionWithData[0].listTask.isEmpty &&
        listSectionWithData[1].listTask.isEmpty) {
      return [];
    }

    return listSectionWithData;
  }

  List<Section> _getListSectionNextWeek() {
    final listSectionNoData = [
      Section.kSectionOverdue,
      Section.kSectionToday.copyWith(isShowIfEmpty: true),
      Section.kSectionTomorrow,
      ...[2, 3, 4, 5, 6]
          .map(
            (numberOfDay) => Section(
                id: DateHelper.getNameOfDay(
                    DateTime.now().add(Duration(days: numberOfDay))),
                name: DateHelper.getNameOfDay(
                    DateTime.now().add(Duration(days: numberOfDay))),
                condition: (dateTime) {
                  return DateHelper.isAfterNumberDay(
                      DateTime.parse(dateTime), numberOfDay);
                }),
          )
          .toList(),
    ];

    return _getListSectionWithDataAndConditionDate(listSectionNoData);
  }

  List<Section> _getListSectionProject() {
    final List<Section> listSectionWithTaskHaveSection =
        _getListSectionWithTaskHaveSection();

    final List<Task> listTaskNoSection = _getListTaskNoSection();

    if (listSectionWithTaskHaveSection.isEmpty && listTaskNoSection.isEmpty) {
      return [];
    }

    final listSectionOfProject = <Section>[];

    if (listTaskNoSection.isNotEmpty) {
      listSectionOfProject
          .add(Section.kSectionNoName.copyWith(listTask: listTaskNoSection));
    }

    listSectionOfProject.addAll(listSectionWithTaskHaveSection);

    return listSectionOfProject;
  }

  List<Section> _getListSectionLabel() {
    final listTask = _listAllTask.where((element) {
      if (element.labels?.isEmpty ?? true) {
        return false;
      }

      return element.labels
          .contains(drawerItems[indexDrawerSelected].data as Label);
    }).toList();

    if (listTask.isNotEmpty) {
      return [Section.kSectionNoName.copyWith(listTask: listTask)];
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

  List<Section> _getListSectionWithTaskHaveSection() {
    final projectSelected = drawerItems[indexDrawerSelected].data as Project;

    final listSectionWithProject =
        listSection.where((element) => element.projectId == projectSelected.id);

    //Add condition date to listSection
    final listSectionWithCondition = listSectionWithProject
        .map((e) => e.copyWith(condition: (value) {
              return value == e.id;
            }))
        .toList();

    //Add data to listSection
    final listSectionWithData =
        _getListSectionWithDataAndConditionSection(listSectionWithCondition);
    return listSectionWithData;
  }

  List<Section> _getListSectionFilter() {
    final listTask = _listAllTask.where((task) {
      return task.priority == drawerItems[indexDrawerSelected].data as int;
    }).toList();

    if (listTask.isNotEmpty) {
      return [Section.kSectionNoName.copyWith(listTask: listTask)];
    }

    return [];
  }
}
