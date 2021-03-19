import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart'
    hide DateUtils;
import 'package:totodo/data/entity/task.dart';

const String kKeyPayloadNotificationIdTask = 'idTask';
const String kKeyButtonActionComplete = 'complete';

void initNotification() {
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    'resource://drawable/icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        importance: NotificationImportance.Max,
      ),
    ],
  );
}

Future<void> showNotificationAtScheduleCron({
  int id,
  String body,
  Map<String, String> payload,
  DateTime scheduleTime,
}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'basic_channel',
      body: body,
      payload: payload,
      autoCancel: true,
    ),
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
    scheduleTime: DateTime.parse(task.taskDate),
  );
}
