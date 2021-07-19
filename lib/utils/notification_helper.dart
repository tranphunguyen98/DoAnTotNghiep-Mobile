import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart'
    hide DateUtils;
import 'package:flutter/material.dart';
import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/task.dart';
import 'package:totodo/utils/util.dart';

const String kValuePayloadNotificationTaskType = 'task';
const String kValuePayloadNotificationHabitType = 'habit';
const String kKeyPayloadNotificationType = 'type';
const String kKeyPayloadNotificationId = 'idTask';
const String kKeyButtonActionComplete = 'complete';
const String kIcon = 'resource://drawable/icon';

const String kGroupKeyMax = 'com.android.example.WORK_EMAIL2';
const String kChannelKeyMax = 'kChannelKeyMax1';
const String kChannelNameMax = 'Basic notifications Totodo Max';
const String kChannelDescriptionMax = 'Notification channel for max importance';

const String kGroupKeyHigh = 'com.android.example.WORK_EMAIL3';
const String kChannelKeyHigh = 'kChannelKeyHigh1';
const String kChannelNameHigh = 'Basic notifications Totodo High';
const String kChannelDescriptionHigh =
    'Notification channel for high importance';

const String kDoneNotificationKey = 'done';
const String kSnoozedNotificationKey = 'snoozed';
void initNotification() {
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    kIcon,
    [
      NotificationChannel(
        channelKey: kChannelKeyMax,
        channelName: kChannelNameMax,
        groupKey: kGroupKeyMax,
        defaultColor: Colors.red,
        channelDescription: kChannelDescriptionMax,
        importance: NotificationImportance.Max,
      ),
      NotificationChannel(
        channelKey: kChannelKeyHigh,
        channelName: kChannelNameHigh,
        groupKey: kGroupKeyHigh,
        channelDescription: kChannelDescriptionHigh,
        importance: NotificationImportance.Default,
      ),
    ],
  );
}

Future<void> showNotificationAtScheduleCron({
  int id,
  String title,
  String body,
  Map<String, String> payload,
  DateTime scheduleTime,
  String crontab,
  String channelKey,
  Color color,
  // // String picture,
  // NotificationLayout notificationLayout,
  List<NotificationActionButton> actionButtons,
}) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey ?? kChannelKeyHigh,
        title: title ?? '',
        body: body,
        payload: payload,
        // notificationLayout: notificationLayout,
        autoCancel: false,
        displayOnForeground: true,
        displayOnBackground: true,
        backgroundColor: color,
        color: color,
        // bigPicture: picture
      ),
      schedule: NotificationSchedule(
        crontabSchedule: crontab ??
            CronHelper.instance.atDate(scheduleTime.toUtc(), initialSecond: 0),
      ),
      actionButtons: actionButtons);
}

Future<void> showNotificationScheduledWithHabit(Habit habit) async {
  habit.remind.forEach((remind) {
    showNotificationAtScheduleCron(
        id: '${habit.id}${remind.minute}${remind.hour}'.hashCode,
        title: habit.name,
        body: habit.motivation.content ?? '',
        payload: {
          kKeyPayloadNotificationType: kValuePayloadNotificationHabitType,
          kKeyPayloadNotificationId: habit.id
        },
        channelKey: kChannelKeyHigh,
        crontab: habit.cronReminder(remind),
        // notificationLayout: NotificationLayout.BigPicture,
        // picture: (habit.motivation?.images?.isNotEmpty ?? false)
        //     ? "file:/${habit.motivation.images[0]}"
        //     : null,
        color: Colors.blue);
  });
}

Future<void> showNotificationScheduledWithTask(Task task) async {
  log('testAsync ${task.dueDate}');
  showNotificationAtScheduleCron(
      id: task.id.hashCode,
      title: task.name,
      payload: {
        kKeyPayloadNotificationType: kValuePayloadNotificationTaskType,
        kKeyPayloadNotificationId: task.id
      },
      scheduleTime: DateTime.parse(task.crontabSchedule),
      channelKey:
          task.priority == Task.kPriority1 ? kChannelKeyMax : kChannelKeyHigh,
      color: getColorFromPriority(task.priority),
      actionButtons: [
        NotificationActionButton(
          key: kDoneNotificationKey,
          label: 'Hoàn thành',
        ),
        NotificationActionButton(
          key: kSnoozedNotificationKey,
          label: 'Hoãn lại (Phút)',
          buttonType: ActionButtonType.InputField,
        )
      ]);
}

Future<void> showNotificationScheduledWithTaskLocal(LocalTask task) async {
  var dateTimeParse = DateTime.parse(task.crontabSchedule);
  log('testAsync crontab ${dateTimeParse.toLocal().toIso8601String()}');
  showNotificationAtScheduleCron(
      id: task.id.hashCode,
      title: task.name,
      payload: {
        kKeyPayloadNotificationType: kValuePayloadNotificationTaskType,
        kKeyPayloadNotificationId: task.id
      },
      scheduleTime: dateTimeParse.toLocal(),
      channelKey:
          task.priority == Task.kPriority1 ? kChannelKeyMax : kChannelKeyHigh,
      color: getColorFromPriority(task.priority),
      actionButtons: [
        NotificationActionButton(
          key: kDoneNotificationKey,
          label: 'Hoàn thành',
        ),
        NotificationActionButton(
          key: kSnoozedNotificationKey,
          label: 'Hoãn lại (Phút)',
          buttonType: ActionButtonType.InputField,
        )
      ]);
}

Color getColorFromPriority(int priority) {
  if (priority == 1) {
    return Colors.red;
  } else if (priority == 2) {
    return Colors.orange;
  } else if (priority == 3) {
    return Colors.blue;
  } else {
    return Colors.black;
  }
}
