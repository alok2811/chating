import 'package:chat_app/app/data/firebase_db_mange.dart';
import 'package:chat_app/app/models/user_model.dart';
import 'package:chat_app/app/modules/chats/views/message_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UsersController extends GetxController with FirebaseUserMange {
  var data = <UsersModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<List<UsersModel>> getAllUsers() async {
    List<UsersModel> userData = await retrieveUsers();
    data.clear();
    for (var element in userData) {
      if (element.uid != FirebaseAuth.instance.currentUser!.uid) {
        data.value.add(element);
      }
    }
    return data.value;
  }

  void startChat({required UsersModel user}) {
    Get.to(() => MessageView(user: user));
  }
}
