import 'package:get/get.dart';

import '../controllers/full_leads_controller.dart';

class FullLeadsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FullLeadsController>(
      () => FullLeadsController(),
    );
  }
}
