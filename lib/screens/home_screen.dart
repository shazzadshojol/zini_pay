import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import 'package:zini_pay/constants/image_path.dart';
import 'package:zini_pay/screens/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(() => _controller.messages.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Image.asset(ImagePath.homeImage),
                      const SizedBox(height: 10),
                      const Text(
                        'Active',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 35),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: _controller.messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final message = _controller.messages[index];
                        return ListTile(
                          title: Text(message['message'] ?? 'No message'),
                          subtitle:
                              Text('Form: ${message['form'] ?? 'No data'}'),
                          trailing: Text(message['timestamp'] ?? 'No data'),
                        );
                      },
                    ),
                  ),
                )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 250,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () {
                    if (_controller.isSyncing.value) {
                      _controller.isSyncing.value = false;
                      _controller.notificationsPlugin.cancel(0);
                    } else {
                      _controller.backgroundSync();
                      _controller.isSyncing.value = true;
                      Workmanager()
                          .registerPeriodicTask('getSmsData', 'sms sync');
                      _controller.notifyUser('Sms syncing in background');
                    }
                  },
                  child: Text(
                    _controller.isSyncing.value ? 'Stop' : 'start',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
