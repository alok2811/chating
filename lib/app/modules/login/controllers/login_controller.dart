import 'package:chat_app/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  RxBool obscurePassword = true.obs;
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  void loginUser() async {
    if (emailTextController.text.trim().isEmpty) {
      showToast(context: Get.context!, message: "Please Enter your email");
      return;
    }
    if (!emailTextController.text.trim().isEmail) {
      showToast(context: Get.context!, message: "Please Enter valid email");
      return;
    }
    if (passwordTextController.text.trim().isEmpty) {
      showToast(context: Get.context!, message: "Please Enter your password");
      return;
    }

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim(),
      );

      if (credential.user != null) {
        Get.offNamed(Routes.HOME);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(
            context: Get.context!, message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToast(
            context: Get.context!,
            message: 'Wrong password provided for that user.');
      } else {
        showToast(context: Get.context!, message: e.message!);
      }
    } catch (e) {
      showToast(context: Get.context!, message: "Something wants wrong");
    }
  }
}
