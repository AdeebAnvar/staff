import 'package:get/get.dart';

import '../controllers/single_snapshot_controller.dart';

class SingleSnapshotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleSnapshotController>(
      () => SingleSnapshotController(),
    );
  }
}
