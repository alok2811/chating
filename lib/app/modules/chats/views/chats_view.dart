import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chats_controller.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('messages').snapshots();

    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("messages").get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return const Center(child: Text("Data Fatch complete"));
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Something wants wrong!"));
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
