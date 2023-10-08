import 'package:get/get.dart';

import '../controllers/old_leads_controller.dart';

class OldLeadsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OldLeadsController>(
      () => OldLeadsController(),
    );
  }
}
