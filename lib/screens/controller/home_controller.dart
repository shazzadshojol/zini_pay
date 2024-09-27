import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zini_pay/constants/urls.dart';

class HomeController extends GetxController {
  RxBool isSyncing = false.obs; // Observable for sync status

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
        Uri.parse(Urls.smsGetUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(smsData),
      );

      log('response: ${response.body}');
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse['success'] == true) {
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
}
