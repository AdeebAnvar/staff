import 'package:get/get.dart';

import '../controllers/custom_itinerary_controller.dart';

class CustomItineraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomItineraryController>(
      () => CustomItineraryController(),
    );
  }
}
