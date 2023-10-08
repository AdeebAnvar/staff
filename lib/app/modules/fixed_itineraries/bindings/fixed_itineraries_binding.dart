import 'package:get/get.dart';

import '../controllers/fixed_itineraries_controller.dart';

class FixedItinerariesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FixedItinerariesController>(
      () => FixedItinerariesController(),
    );
  }
}
