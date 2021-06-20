import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart'
    hide DateUtils;
import 'package:flutter/material.dart';
import 'package:totodo/data/model/task.dart';

const String kKeyPayloadNotificationIdTask = 'idTask';
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
  String body,
  Map<String, String> payload,
  DateTime scheduleTime,
  String channelKey,
  Color color,
}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: id,
        channelKey: channelKey ?? kChannelKeyHigh,
        body: body,
        payload: payload,
        autoCancel: false,
        displayOnForeground: true,
        displayOnBackground: true,
        backgroundColor: color,
        color: color),
    schedule: NotificationSchedule(
      crontabSchedule:
          CronHelper.instance.atDate(scheduleTime.toUtc(), initialSecond: 0),
    ),
  );
}

Future<void> showNotificationScheduledWithTask(Task task) async {
  showNotificationAtScheduleCron(
      id: task.id.hashCode,
      body: task.name,
      payload: {kKeyPayloadNotificationIdTask: task.id},
      scheduleTime: DateTime.parse(task.dueDate),
      channelKey:
          task.priority == Task.kPriority1 ? kChannelKeyMax : kChannelKeyHigh,
      color: getColorFromPriority(task.priority));
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
