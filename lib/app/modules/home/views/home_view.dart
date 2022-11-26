import 'package:chat_app/app/modules/users/views/users_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Welcome ${FirebaseAuth.instance.currentUser!.displayName!.split(' ').first}'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  controller.logoutUser();
                },
                icon: const Icon(Icons.power_settings_new_outlined))
          ],
        ),
        body: const UsersView());
  }
}
