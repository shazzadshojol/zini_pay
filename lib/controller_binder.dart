import 'package:get/get.dart';
import 'package:zini_pay/screens/controller/home_controller.dart';
import 'package:zini_pay/screens/controller/login_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
  }
}
