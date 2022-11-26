import 'package:chat_app/app/modules/chats/controllers/chats_controller.dart';
import 'package:get/get.dart';

import '../../users/controllers/users_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<UsersController>(
      () => UsersController(),
    );

    Get.lazyPut<ChatsController>(
      () => ChatsController(),
    );
  }
}
