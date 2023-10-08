import 'package:get/get.dart';

import '../controllers/calling_page_controller.dart';

class CallingPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallingPageController>(
      () => CallingPageController(),
    );
  }
}
