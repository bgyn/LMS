import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message ${message.messageId}');
}

class NotificationServices {
  static final NotificationServices _instance =
      NotificationServices._internal();

  factory NotificationServices() {
    return _instance;
  }

  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late final FirebaseMessaging _firebaseMessaging;

  NotificationServices._internal() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _firebaseMessaging = FirebaseMessaging.instance;
    initializeNotification();
  }

  //initialize notification
  Future<void> initializeNotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    //intialize local notification
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

    /// todo ios setting

    //initialize local notification
    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: androidSetting,
      ),
    );

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint("Received foreground notificaiton : ${message.messageId}");
    await _showLocalNotification(
      title: message.notification?.title ?? 'Default Title',
      body: message.notification?.body ?? 'Default Body',
    );
  }

  Future<void> _showLocalNotification(
      {required String title, required String body, String? payload}) async {
    const androidDetail = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().second,
      title,
      body,
      const NotificationDetails(android: androidDetail),
      payload: payload,
    );
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}
