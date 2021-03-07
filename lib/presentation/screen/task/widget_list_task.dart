import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:totodo/bloc/submit_task/bloc.dart';
import 'package:totodo/bloc/submit_task/task_submit_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/task/widget_item_task.dart';

import '../../router.dart';

class ListTask extends StatelessWidget {
  final List<Task> listTask;
  final TaskSubmitBloc _taskSubmitBloc = getIt<TaskSubmitBloc>();

  ListTask(this.listTask);

  @override
  Widget build(BuildContext context) {
    _MyHomePageState();
    return BlocListener<TaskSubmitBloc, TaskSubmitState>(
      cubit: _taskSubmitBloc,
      listener: (context, state) {
        if (state.success) {
          getIt<TaskBloc>().add(DataListTaskChanged());
          _taskSubmitBloc.add(HandledSuccessState());
        }
      },
      child: ReorderableList(
        // onReorder: (oldIndex, newIndex) {
        //         //   print("oldIndex $oldIndex newIndex: $newIndex");
        //         // },
        onReorder: (draggedItem, newPosition) {
          print("oldIndex $draggedItem newIndex: $newPosition");
          return true;
        },
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            // SliverPadding(
            //   padding: EdgeInsets.only(
            //       bottom: MediaQuery.of(context).padding.bottom),
            //   sliver: SliverList(
            //     delegate: SliverChildBuilderDelegate(
            //       (BuildContext context, int index) {
            //         return ItemTask(
            //           key: ValueKey(listTask[index].id),
            //           task: listTask[index],
            //           updateTask: (task) {
            //             _taskSubmitBloc.add(SubmitEditTask(task));
            //           },
            //           onPressed: (Task task) {
            //             Navigator.of(context)
            //                 .pushNamed(AppRouter.kDetailTask, arguments: task);
            //           },
            //         );
            //       },
            //       childCount: listTask.length,
            //     ),
            //   ),
            // ),
            SliverPadding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ItemTaskReorder(
                        data: listTask[index],
                        // first and last attributes affect border drawn during dragging
                        isFirst: index == 0,
                        isLast: index == _items.length - 1,
                        draggingMode: _draggingMode,
                        updateTask: (task) {
                          _taskSubmitBloc.add(SubmitEditTask(task));
                        },
                        onPressed: (Task task) {
                          Navigator.of(context).pushNamed(AppRouter.kDetailTask,
                              arguments: task);
                        },
                      );
                    },
                    childCount: listTask.length,
                  ),
                )),
          ],
        ),
        // SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       ...listTask
        //           .map((task) => ItemTask(
        //                 key: ValueKey(task.id),
        //                 task: task,
        //                 updateTask: (task) {
        //                   _taskSubmitBloc.add(SubmitEditTask(task));
        //                 },
        //                 onPressed: (Task task) {
        //                   Navigator.of(context).pushNamed(AppRouter.kDetailTask,
        //                       arguments: task);
        //                 },
        //               ))
        //           .toList()
        //     ],
        //   ),
        // ),

        // separatorBuilder: (context, index) {
        //   return Divider(
        //     thickness: 1.0,
        //     height: 1.0,
        //   );
        // },
        // itemCount: listTask.length,
      ),
    );
  }
}

DraggingMode _draggingMode = DraggingMode.Android;

List<ItemData> _items;

_MyHomePageState() {
  _items = List();
  for (int i = 0; i < 500; ++i) {
    String label = "List item $i";
    if (i == 5) {
      label += ". This item has a long label and will be wrapped.";
    }
    _items.add(ItemData(label, ValueKey(i)));
  }
}

class ItemData {
  ItemData(this.title, this.key);

  final String title;

  // Each item in reorderable list needs stable and unique key
  final Key key;
}

enum DraggingMode {
  iOS,
  Android,
}

class Item extends StatelessWidget {
  Item({
    this.data,
    this.isFirst,
    this.isLast,
    this.draggingMode,
  });

  final ItemData data;
  final bool isFirst;
  final bool isLast;
  final DraggingMode draggingMode;

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
              top: isFirst && !placeholder
                  ? Divider.createBorderSide(context) //
                  : BorderSide.none,
              bottom: isLast && placeholder
                  ? BorderSide.none //
                  : Divider.createBorderSide(context)),
          color: placeholder ? null : Colors.white);
    }

    // For iOS dragging mode, there will be drag handle on the right that triggers
    // reordering; For android mode it will be just an empty container
    Widget dragHandle = draggingMode == DraggingMode.iOS
        ? ReorderableListener(
            child: Container(
              padding: EdgeInsets.only(right: 18.0, left: 18.0),
              color: Color(0x08000000),
              child: Center(
                child: Icon(Icons.reorder, color: Color(0xFF888888)),
              ),
            ),
          )
        : Container();

    Widget content = Container(
      decoration: decoration,
      child: SafeArea(
          top: false,
          bottom: false,
          child: Opacity(
            // hide content for placeholder
            opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                    child: Text(data.title,
                        style: Theme.of(context).textTheme.subtitle1),
                  )),
                  // Triggers the reordering
                  dragHandle,
                ],
              ),
            ),
          )),
    );

    // For android dragging mode, wrap the entire content in DelayedReorderableListener
    if (draggingMode == DraggingMode.Android) {
      content = DelayedReorderableListener(
        child: content,
      );
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
        key: data.key, //
        childBuilder: _buildChild);
  }
}
