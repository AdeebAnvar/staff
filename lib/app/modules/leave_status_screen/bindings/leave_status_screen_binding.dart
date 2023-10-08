import 'package:get/get.dart';

import '../controllers/leave_status_screen_controller.dart';

class LeaveStatusScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveStatusScreenController>(
      () => LeaveStatusScreenController(),
    );
  }
}
