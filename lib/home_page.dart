// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'notification_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationServices _notificationServices = NotificationServices();

  @override
  void initState() {
    _notificationServices.requestNotificationsPermition();

    _notificationServices.getDeviceToken().then(
          (value) => print(value),
        );

    _notificationServices.firebaseInit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is title"),
      ),
    );
  }
}
