import 'package:bubble/bubble.dart';
import 'package:chat_app/app/common/common.dart';
import 'package:chat_app/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../widgets/custom_card.dart';

class ChatsController extends GetxController {
  //TODO: Implement ChatsController
  TextEditingController textEditingController = TextEditingController();

  var emojiShowing = false.obs;

  String groupChatId({required String currentId, required String peerId}) {
    if (currentId.hashCode <= peerId.hashCode) {
      return '$currentId-$peerId';
    } else {
      return '$peerId-$currentId';
    }
  }

  Future<void> sendMessage(
      {required String groupChatId, required UsersModel user}) async {
    // type: 0 = text, 1 = image, 2 = sticker
    if (textEditingController.text.trim() != '') {
      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': FirebaseAuth.instance.currentUser!.uid,
            'idTo': user.uid,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'group': DateFormat("dd-MM-yyyy").format(DateTime.now()),
            'content': textEditingController.text.trim(),
            'type': '0'
          },
        );
      });
      //listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      textEditingController.clear();
    } else {
      showToast(context: Get.context!, message: 'Nothing to send');
    }
  }

  buildGroupedItem(
      Map<dynamic, List<QueryDocumentSnapshot<Map<String, dynamic>>>> map) {
    map.forEach((key, value) {
      StickyGroupedListView<dynamic, String>(
        elements: value,
        groupBy: (dynamic element) => key,
        groupSeparatorBuilder: (dynamic element) => Text(key),
        itemBuilder: (context, dynamic element) =>
            buildItem(value.first), // optional/ optional
      );
    });
  }

  buildItem(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return uid == doc['idFrom']
        ? Bubble(
            margin: const BubbleEdges.only(top: 10),
            alignment: Alignment.topRight,
            nip: BubbleNip.rightTop,
            color: const Color.fromRGBO(225, 255, 199, 1.0),
            child: CustomCard(
              msg: doc['content'],
              additionalInfo: DateFormat("hh:mm a").format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(doc['timestamp']))),
            ),
          )
        : Bubble(
            margin: const BubbleEdges.only(top: 10),
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftTop,
            child: CustomCard(
              msg: doc['content'],
              additionalInfo: DateFormat("hh:mm a").format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(doc['timestamp']))),
            ),
          );
  }

  String getDate({required String data}) {
    String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String yesterday = DateFormat('dd-MM-yyyy')
        .format(DateTime.now().subtract(const Duration(days: 1)));

    if (data.contains(today)) {
      return "Today";
    }

    if (data.contains(yesterday)) {
      return "Yesterday";
    }
    return data;
  }
}
