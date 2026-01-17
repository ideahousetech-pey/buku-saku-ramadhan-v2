import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class AdzanNotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _notifications.initialize(
      const InitializationSettings(android: android),
    );
  }

  static Future<void> cancel(int id) async {
    await _notifications.cancel(id);
  }

  static Future<void> schedule({
    required int id,
    required String sholat,
    required String time,
  }) async {
    final now = DateTime.now();
    final parts = time.split(':');

    final scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );

    if (scheduled.isBefore(tz.TZDateTime.now(tz.local))) return;

    final sound =
        sholat.toLowerCase() == 'subuh' ? 'adzan_fajr' : 'adzan';

    await _notifications.zonedSchedule(
      id,
      'Adzan ${_cap(sholat)}',
      'Waktunya sholat ${_cap(sholat)}',
      scheduled,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'adzan_channel',
          'Adzan',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound(sound),
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static String _cap(String t) =>
      t[0].toUpperCase() + t.substring(1);
}
