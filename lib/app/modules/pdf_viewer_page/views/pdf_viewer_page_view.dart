import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_empty_screen.dart';
import '../controllers/pdf_viewer_page_controller.dart';

class PdfViewerPageView extends GetView<PdfViewerPageController> {
  const PdfViewerPageView({super.key});
  @override
  Widget build(BuildContext context) {
    final PdfViewerPageController controller =
        Get.put(PdfViewerPageController());
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(controller.tourCode.toString()),
        actions: <Widget>[
          Card(
            child: IconButton(
              onPressed: () {
                controller.sharePdf();
              },
              icon: const Icon(Icons.send),
            ),
          )
        ],
      ),
      body: controller.obx(
        onError: (String? error) => const CustomEmptyScreen(label: 'No Pdf'),
        onLoading: const Center(child: CircularProgressIndicator()),
        (PdfViewerPageView? state) => SfPdfViewer.network(
          controller.pdfPath.toString(),
          key: controller.pdfViewerKey,
        ),
      ),
    );
  }
}
