import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zini_pay/constants/urls.dart';
import 'package:zini_pay/data/model/user_model.dart';
import 'package:zini_pay/screens/home_screen.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController apiKeyController = TextEditingController();
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  RxBool isLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;
      update();

      Map<String, dynamic> inputData = {
        'email': emailController.text.trim(),
        'apiKey': apiKeyController.text.trim()
      };

      final response = await http.post(
        Uri.parse(Urls.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(inputData),
      );
      log('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        if (decodedResponse['success'] == true) {
          userModel.value = UserModel(
            email: inputData['email'],
            apiKey: inputData['apiKey'],
          );
          log('Login successful: ${decodedResponse['message']}');

          Get.snackbar('Success', decodedResponse['message']);

          Get.offAll(() => const HomeScreen());
        } else {
          Get.snackbar('Failed', 'Invalid email or API key');
        }
      } else {
        log('Login failed: ${response.statusCode}');

        Get.snackbar('Error', 'Login failed. Please try again.');
      }
    } catch (e) {
      log('Error with: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
