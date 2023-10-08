import 'package:get/get.dart';

import '../controllers/previous_bookings_controller.dart';

class PreviousBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviousBookingsController>(
      () => PreviousBookingsController(),
    );
  }
}
