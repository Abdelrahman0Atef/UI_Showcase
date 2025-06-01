import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:untitled/core/resources/my_assets.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final androidSettings = const AndroidInitializationSettings(
      '${MyAssets.appIcon}',
    );
    final initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestExactAlarmsPermission();
  }

  Future<void> schedulePrayerNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime dateTime,
    String? soundFileName,
  }) async {
    AndroidNotificationSound? androidSound;
    if (soundFileName != null && soundFileName.isNotEmpty) {
      androidSound = RawResourceAndroidNotificationSound(soundFileName);
    }
    final androidDetails = AndroidNotificationDetails(
      'prayer_channel',
      'Prayer Notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound: androidSound,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      dateTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
