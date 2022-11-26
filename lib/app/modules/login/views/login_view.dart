import 'package:chat_app/app/common/common.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Chat App",
                  style: Theme.of(context).textTheme.headline2,
                ),
                spaceVertical(20),
                TextFieldWidget(
                  textEditingController: controller.emailTextController,
                  hintText: "EMAIL",
                  prefixIcon: const Icon(Icons.mail),
                ),
                spaceVertical(10),
                Obx(() {
                  return TextFieldWidget(
                    textEditingController: controller.passwordTextController,
                    hintText: "PASSWORD",
                    obscureText: controller.obscurePassword.value,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(controller.obscurePassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        controller.obscurePassword.value =
                            !controller.obscurePassword.value;
                      },
                    ),
                  );
                }),
                spaceVertical(10),
                ElevatedButtonWidget(
                  onPress: () {
                    controller.loginUser();
                  },
                  title: "Login",
                ),
                spaceVertical(20),
                RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account?',
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Sign up',
                            style: const TextStyle(
                                color: Colors.blueAccent, fontSize: 18),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routes.REGISTER);
                                // navigate to desired screen
                              })
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}
