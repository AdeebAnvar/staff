import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/utils/constants.dart';
import '../../../data/repository/network_repo/custombookingrepo.dart';

class PdfController extends GetxController {
  String? pdf;
  String? customerId;
  RxString loadingString = RxString('');
  RxBool isLoading = false.obs;
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    if (Get.arguments != null) {
      pdf = Get.arguments[0] as String;
      customerId = Get.arguments[1] as String;
    }
  }

  Future<void> sharePdf() async {
    log('message');
    try {
      isLoading(true);
      try {
        loadingString.value = 'Feching PDF . . . ';
        loadingDialogue();

        final Directory directory = await getTemporaryDirectory();
        final File file = File('${directory.path}/custom_itinerary.pdf');
        // Assuming pdfPath is the correct path to the generated PDF
        final File pdfFile = File(pdf.toString());

        // Check if the PDF file exists before copying and sharing
        if (pdfFile.existsSync()) {
          // Copy the PDF file to the temporary directory
          await pdfFile.copy(file.path);
          await sendPDFtoDash(file.path);
          // Share the copied PDF file
          // await Share.shareFiles(<String>[file.path]);
        } else {
          // Handle the case when the PDF file does not exist
          log('PDF file does not exist at $pdf');
        }
      } finally {
        isLoading(false);
        Get.back();
        Get.snackbar(
          'Itinerary Sent',
          '',
          backgroundColor: getColorFromHex(depColor),
          colorText: Colors.white,
          forwardAnimationCurve: Curves.bounceIn,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Itinerary cant Sent',
        '',
        backgroundColor: getColorFromHex(depColor),
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
      );
      log(e.toString());
    }
  }

  Future<void> sendPDFtoDash(String path) async {
    try {
      loadingString.value = 'Sending  . . . ';

      await CustomBookingRepo().postProposals(cid: customerId!, pdf: path);
    } catch (e) {
      log(e.toString());
    }
  }

  void loadingDialogue() {
    Get.dialog(
      transitionCurve: Curves.bounceInOut,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Align(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(
                    color: getColorFromHex(depColor),
                  ),
                ),
                SizedBox(height: 30),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                          style: TextStyle(color: Colors.black),
                          child: Text(loadingString.value)),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
