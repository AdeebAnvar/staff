import 'package:get/get.dart';

import '../controllers/custom_booking_controller.dart';

class CustomBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomBookingController>(
      () => CustomBookingController(),
    );
  }
}
