import 'package:get/get.dart';

import '../controllers/fresh_leads_controller.dart';

class FreshLeadsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreshLeadsController>(
      () => FreshLeadsController(),
    );
  }
}
