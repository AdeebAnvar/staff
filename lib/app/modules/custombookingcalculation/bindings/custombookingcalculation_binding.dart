import 'package:get/get.dart';

import '../controllers/custombookingcalculation_controller.dart';

class CustombookingcalculationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustombookingcalculationController>(
      () => CustombookingcalculationController(),
    );
  }
}
