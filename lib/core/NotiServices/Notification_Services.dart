import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  final FlutterLocalNotificationsPlugin notificatPlugin =
      FlutterLocalNotificationsPlugin();
  bool _isInit = false;

  bool get isInit => _isInit;

  Future<void> initNotification() async {
    if (_isInit) {
      return;
    }
    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //       AndroidFlutterLocalNotificationsPlugin
    //     >()
    //     ?.requestNotificationsPermission();
    const initAndroidSettings = AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );
    const initIosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initAndroidSettings,
      iOS: initIosSettings,
    );

    await notificatPlugin.initialize(initSettings);
    _isInit = true;

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      description: 'This is the description of the channel',
      importance: Importance.max,
      enableLights: true,
      enableVibration: true,
      showBadge: true,
      sound: RawResourceAndroidNotificationSound('sound'),
      playSound: true,
    );

    await notificatPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  NotificationDetails notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'Description of the channel',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('sound'),

        priority: Priority.max,
        playSound: true,
        enableVibration: true,
        vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    if (title == null || body == null) {
      title = "Default Title"; // Default title
      body = "Default Notification Body"; // Default body
    }

    await notificatPlugin.show(id, title, body, notificationDetails());
  }

  Future<void> testNotification() async {
    await showNotification(
      title: "Test Notification",
      body: "This is a test notification!",
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'prayer_channel_id2',
        'Prayer Notifications',
        channelDescription: 'Reminder for prayer times',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('sound'),

        category: AndroidNotificationCategory.reminder,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await notificatPlugin.zonedSchedule(
      id,
      title,
      body,
      payload: 'Praying Time',
      tz.TZDateTime.from(scheduledDate, tz.local),
      androidScheduleMode: AndroidScheduleMode.exact,
      details,

      matchDateTimeComponents: DateTimeComponents.time, // for daily
    );
  }
}
