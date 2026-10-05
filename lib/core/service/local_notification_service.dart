import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static final LocalNotificationService instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/launcher_icon',
      ),
      windows: WindowsInitializationSettings(
        appName: 'Hungry',
        appUserModelId: 'com.hungry.app',
        guid: 'd7f9b2a1-4c3e-4a8b-9f21-123456789abc',
      ),
    );

    await _notifications.initialize(
      settings: settings,
    );

    const channel = AndroidNotificationChannel(
      'hungry_channel',
      'Hungry Notifications',
      description: 'Hungry app notifications',
      importance: Importance.high,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
    int id = 0,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'hungry_channel',
      'Hungry Notifications',
      channelDescription: 'Hungry app notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }
}
