import 'package:get/get.dart';

import '../controllers/single_booking_details_controller.dart';

class SingleBookingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleBookingDetailsController>(
      () => SingleBookingDetailsController(),
    );
  }
}
