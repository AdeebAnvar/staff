import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/utils/constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../controllers/no_internet_controller.dart';

class NoInternetView extends GetView<NoInternetController> {
  const NoInternetView({super.key});
  @override
  Widget build(BuildContext context) {
    final NoInternetController controller = Get.put(NoInternetController());
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: getColorFromHex(depColor),
          ),
          onPressed: () {
            Get.back();
            // Get..offAllNamed();
          },
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => controller.sharePdf(),
              icon: const Icon(Icons.share))
        ],
      ),
      body: SfPdfViewer.file(
        File(controller.customItineraryDatas!),
        key: controller.pdfViewerKey,
      ),
    );
  }
}
