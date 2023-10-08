import 'package:get/get.dart';

import '../controllers/telecaller_profile_controller.dart';

class TelecallerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TelecallerProfileController>(
      () => TelecallerProfileController(),
    );
  }
}
