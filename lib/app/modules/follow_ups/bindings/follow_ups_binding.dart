import 'package:get/get.dart';

import '../controllers/follow_ups_controller.dart';

class FollowUpsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowUpsController>(
      () => FollowUpsController(),
    );
  }
}
