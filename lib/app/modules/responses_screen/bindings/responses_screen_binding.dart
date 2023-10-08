import 'package:get/get.dart';

import '../controllers/responses_screen_controller.dart';

class ResponsesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResponsesScreenController>(
      () => ResponsesScreenController(),
    );
  }
}
