import 'package:get/get.dart';

import '../controllers/category_wise_leads_controller.dart';

class CategoryWiseLeadsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryWiseLeadsController>(
      () => CategoryWiseLeadsController(),
    );
  }
}
