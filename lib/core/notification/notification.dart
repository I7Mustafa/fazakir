import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../models/received_notification/received_notification.dart';
import '../date/time_zone_co.dart';

class NotificationService {
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static final _didReceiveNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

  static final _selectNotificationStream =
      StreamController<String?>.broadcast();

  static const String _navigationActionId = 'id_3';

  static const String _adahnNotificationChannel = "Adahn Channel";
  static const String _adahnNotificationChannelName = "Adahn Channel";
  static const String _adahnNotificationChannelDescription =
      "Adahn Channel that sends a notification for every adhan";

  static Future<void> init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      'launcher_icon',
    );

    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    await _requestNotificationPermission();
  }

  static Future<void> _requestNotificationPermission() async {
    if (Platform.isIOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isMacOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final androidPlugin =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final notificationsGranted =
          await androidPlugin?.requestNotificationsPermission();
      final alarmsGranted = await androidPlugin?.requestExactAlarmsPermission();

      if (notificationsGranted != true || alarmsGranted != true) {
        log('Notification permissions not granted');
      }
    }
  }

  static AndroidNotificationDetails get _androidNotificationDetails =>
      const AndroidNotificationDetails(
        _adahnNotificationChannel,
        _adahnNotificationChannelName,
        channelDescription: _adahnNotificationChannelDescription,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        visibility: NotificationVisibility.public,
        channelShowBadge: true,
        groupAlertBehavior: GroupAlertBehavior.all,
      );

  static Future<void> sendScheduleNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    required int second,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      TimeZoneHelper.setTime(hour, minute, second),
      NotificationDetails(android: _androidNotificationDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static void _onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    if (notificationResponse.notificationResponseType ==
            NotificationResponseType.selectedNotification ||
        (notificationResponse.notificationResponseType ==
                NotificationResponseType.selectedNotificationAction &&
            notificationResponse.actionId == _navigationActionId)) {
      _selectNotificationStream.add(payload);
    }
  }

  static void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    _didReceiveNotificationStream.add(ReceivedNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
    ));
  }
}
