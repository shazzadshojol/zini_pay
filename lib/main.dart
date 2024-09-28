import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:zini_pay/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  runApp(MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    FlutterLocalNotificationsPlugin localNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    localNotificationsPlugin.show(
        0,
        'Sync done',
        'Sync is finished',
        const NotificationDetails(
            android:
                AndroidNotificationDetails('Sync', 'SMS Sync Background')));
    FlutterLocalNotificationsPlugin notificationsPlugin =
        FlutterLocalNotificationsPlugin();

    notificationsPlugin.cancel(0);
    print('From Work manager');
    return Future.value(true);
  });
}
