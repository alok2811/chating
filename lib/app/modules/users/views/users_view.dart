import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: controller.data.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    onTap: () {
                      controller.startChat(user: controller.data.value[index]);
                    },
                    title: Text(controller.data.value[index].name),
                    subtitle: Text(controller.data.value[index].email),
                    trailing: const Icon(Icons.mail),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something want wrong!"),
              );
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    return Obx(() => controller.data.value.isEmpty
        ? noDataFound()
        : ListView.builder(
            itemCount: controller.data.value.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                onTap: () {
                  controller.startChat(user: controller.data.value[index]);
                },
                title: Text(controller.data.value[index].name),
                subtitle: Text(controller.data.value[index].email),
                trailing: const Icon(Icons.mail),
              );
            },
          ));
  }
}
