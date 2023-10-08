import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class NoInternetController extends GetxController {
  String? customItineraryDatas;
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    if (Get.arguments[0] != null) {
      customItineraryDatas = Get.arguments[0] as String;
    }
  }

  Future<void> sharePdf() async {
    try {
      final Directory directory = await getTemporaryDirectory();
      final File file = File('${directory.path}/custom_itinerary.pdf');

      // Assuming pdfPath is the correct path to the generated PDF
      final File pdfFile = File(customItineraryDatas.toString());

      // Check if the PDF file exists before copying and sharing
      if (pdfFile.existsSync()) {
        // Copy the PDF file to the temporary directory
        await pdfFile.copy(file.path);

        // Share the copied PDF file
        await Share.shareFiles(<String>[file.path]);
      } else {
        // Handle the case when the PDF file does not exist
        log('PDF file does not exist at $customItineraryDatas');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
