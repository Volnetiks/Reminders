import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationsApi {
  static final notifications = FlutterLocalNotificationsPlugin();

  static Future notificationsDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'reminders_1',
        'reminders_notifications',
        importance: Importance.max,
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: IOSInitializationSettings());

    await notifications.initialize(settings,
        onSelectNotification: (payload) async {});
  }

  static void showScheduledNotification(
          {int id = 0,
          String? title,
          String? body,
          String? payload,
          required DateTime scheduledDate}) async =>
      {
        tz.initializeTimeZones(),
        notifications.zonedSchedule(
            id,
            title,
            body,
            tz.TZDateTime.from(scheduledDate, tz.local),
            await notificationsDetails(),
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime)
      };
}
