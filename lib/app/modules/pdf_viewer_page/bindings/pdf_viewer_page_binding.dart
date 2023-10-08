import 'package:get/get.dart';

import '../controllers/pdf_viewer_page_controller.dart';

class PdfViewerPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PdfViewerPageController>(
      () => PdfViewerPageController(),
    );
  }
}
