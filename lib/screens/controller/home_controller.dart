import 'dart:convert';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zini_pay/constants/urls.dart';

class HomeController extends GetxController {
  RxBool isSyncing = false.obs;
  RxList<dynamic> messages = <dynamic>[].obs;
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _notifyConfig();
  }

  void backgroundSync() async {
    if (isSyncing.value) {
      isSyncing.value = false;
      Get.snackbar('Info', 'SMS sync stopped');
    } else {
      bool isSuccess = await syncSMS();

      if (isSuccess) {
        isSyncing.value = true;
        Get.snackbar('Info', 'SMS sync started');
      } else {
        Get.snackbar('Error', 'SMS sync failed');
      }
    }
  }

  Future<bool> syncSMS() async {
    try {
      Map<String, dynamic> smsData = {
        "message": "Test message now",
        "from": "+1234567890",
        "timestamp": DateTime.now().toIso8601String(),
      };

      final response = await http.post(
        Uri.parse(Urls.smsUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(smsData),
      );

      log('response: ${response.body}');
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse['success'] == true) {
          messages.add({
            "message": smsData["message"],
            "from": smsData["from"],
            "timestamp": smsData["timestamp"],
          });
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log('Error syncing SMS: $e');
      return false;
    }
  }

  Future<void> _notifyConfig() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> notifyUser(String msg) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Sync', 'SMS Sync Background',
            showWhen: false,
            importance: Importance.max,
            priority: Priority.high,
            ongoing: true);

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await notificationsPlugin.show(
        0, 'Syncing', msg, notificationDetails); // payload didn't used
  }
}
