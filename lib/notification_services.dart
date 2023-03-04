// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  // initialising firebae message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // function to request notifications permissions
  void requestNotificationsPermition() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user  grandted provisional');
    } else {
      print("denied the permission");
    }
  }

  // function to get device token on which we will send the notifications
  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  // void isTokenRefresh() async {
  //   messaging.onTokenRefresh.listen((event) {
  //     event.toString();
  //     print("refresh");
  //   });
  // }

  // function to initialise flutter local notification plugin to show
  // notifications for android when app is active

  final FlutterLocalNotificationsPlugin _flutterlocationNotifications =
      FlutterLocalNotificationsPlugin();

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // for ios
    // var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iosInitializationSettings
    );

    await _flutterlocationNotifications.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {},
    );
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }

      showNotifications(message);
    });
  }

  // function to show visible notification when app is active
  Future<void> showNotifications(RemoteMessage message) async {
    // Android Notification Settings
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(1000000).toString(),
      "High Importance Notifications",
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "your channel discription",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
    );

    /*
    //  for ios

     const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true ,
      presentBadge: true ,
      presentSound: true
    ) ;

    */

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      // iOS: darwinNotificationDetails
    );

    Future.delayed(Duration.zero, () {
      _flutterlocationNotifications.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }
}
