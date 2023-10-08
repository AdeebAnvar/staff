import 'package:get/get.dart';

import '../controllers/single_lead_controller.dart';

class SingleLeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleLeadController>(
      () => SingleLeadController(),
    );
  }
}
