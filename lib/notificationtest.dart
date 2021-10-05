import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:login_signup_page/main.dart';

class NotificationTest extends StatefulWidget {
  const NotificationTest({ Key? key }) : super(key: key);

  @override
  _NotificationTestState createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {

  setup() {
    FirebaseMessaging.onMessage.listen((event) {
      print("message alert....");
      RemoteNotification noti = event.notification!;
      print("Title ${noti.title} Body ${noti.body}");

      flutterLocalNotificationsPlugin.show(
        noti.hashCode,
        noti.title,
        noti.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Center(
          // child: Text("dbvkufhv")
        )
      ),
    );
  }
}