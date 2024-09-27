import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zini_pay/constants/image_path.dart';
import 'package:zini_pay/screens/controller/login_controller.dart';
import 'package:zini_pay/widgets/loading_indicator.dart';
import 'package:zini_pay/widgets/textfield_name.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagePath.loginImage),
            _buildLoginText(),
            _buildTextFieldSection()
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldSection() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFieldName(
            text: 'Email',
          ),
          TextField(
            controller: _loginController.emailController,
            decoration: const InputDecoration(
                hintText: 'johndoe@example.com',
                hintStyle: TextStyle(
                    color: Colors.white54, fontWeight: FontWeight.w300)),
          ),
          const SizedBox(height: 10),
          const TextFieldName(
            text: 'Api Key',
          ),
          TextField(
            controller: _loginController.apiKeyController,
            // obscureText: true,
            decoration: const InputDecoration(
                hintText: 'Api Key',
                hintStyle: TextStyle(color: Colors.white54)),
          ),
          const SizedBox(height: 30),
          Obx(
            () => _loginController.isLoading.value
                ? const LoadingIndicator()
                : ElevatedButton(
                    onPressed: () {
                      _loginController.login();
                    },
                    child: const Text(
                      'Log in',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Text _buildLoginText() {
    return const Text(
      'Log in',
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
    );
  }
}
