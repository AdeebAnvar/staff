import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../widgets/custom_appbar.dart';
import '../controllers/pdf_controller.dart';

class PdfView extends GetView<PdfController> {
  const PdfView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
      body: SfPdfViewer.file(
        File(controller.pdf!),
        key: controller.pdfViewerKey,
      ),
    );
  }
}
