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
    // TODO: implement initState
    _notificationServices.requestNotificationsPermition();
    super.initState();


    _notificationServices.getDeviceToken().then((value) => 
    
     print(value),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const  Text("This is title"),),
    );
  }
}
