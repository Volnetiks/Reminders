import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static void showScheduledNotification(
          {int id = 0,
          String? title,
          String? body,
          String? payload,
          required DateTime scheduledDate}) async =>
      {_};
}
