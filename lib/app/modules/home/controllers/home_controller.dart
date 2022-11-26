import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  void logoutUser() async {
    Get.defaultDialog(
        content: const Text("Are you sure you want to logout?"),
        onConfirm: () async {
          await FirebaseAuth.instance.signOut();
          Get.offAllNamed(Routes.LOGIN);
        },
        onCancel: () {
          if (Get.isDialogOpen!) {
            Get.back();
          }
        });
  }
}
