import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zini_pay/constants/app_colors.dart';
import 'package:zini_pay/controller_binder.dart';

import 'screens/login_page.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      initialBinding: ControllerBinder(),
      theme: ThemeData(
          elevatedButtonTheme: _buildElevatedButtonThemeData(),
          inputDecorationTheme: _inputDecorationTheme()),
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.maxFinite, 55),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white),
    );
  }

  InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
      hintStyle:
          const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
      border: _outlineInputBorder,
      enabledBorder: _outlineInputBorder,
      focusedBorder: _outlineInputBorder,
      errorBorder: _outlineInputBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      filled: true,
      fillColor: Colors.grey);

  final OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(20));
}
