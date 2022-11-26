import 'package:chat_app/app/common/common.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  RxBool obscurePassword = true.obs;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  void registerUser() async {
    if (nameTextController.text.trim().isEmpty) {
      showToast(context: Get.context!, message: "Please Enter your name");
      return;
    }
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
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim(),
      );

      if (credential.user != null) {
        FirebaseAuth.instance.currentUser!
            .updateDisplayName(nameTextController.text.trim());

        addUser(
          uid: FirebaseAuth.instance.currentUser!.uid,
          name: nameTextController.text.trim(),
          email: emailTextController.text.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast(
            context: Get.context!,
            message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast(
            context: Get.context!,
            message: 'The account already exists for that email.');
      } else {
        showToast(context: Get.context!, message: e.message!);
      }
    } catch (e) {
      showToast(context: Get.context!, message: "Something wants wrong!");
    }
  }

  void addUser({
    required String uid,
    required String name,
    required String email,
  }) async {
    var path = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    try {
      await path.set({"uid": uid, "name": name, "email": email});
      showToast(context: Get.context!, message: "User updated");
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      showToast(context: Get.context!, message: "Something wants wrong!");
    }
  }
}
