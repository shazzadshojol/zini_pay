import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zini_pay/constants/image_path.dart';
import 'package:zini_pay/screens/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(ImagePath.homeImage),
                const SizedBox(height: 10),
                const Text(
                  'Active',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 250,
            child: Obx(() => ElevatedButton(
                onPressed: () {
                  _controller.backgroundSync();
                },
                child: Text(_controller.isSyncing.value ? 'Stop' : 'start',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 22)))),
          )
        ],
      ),
    );
  }
}
