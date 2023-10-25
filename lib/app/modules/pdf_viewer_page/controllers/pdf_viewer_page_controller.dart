// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/constants.dart';
import '../../../data/models/network_models/itinerary_model.dart';
import '../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../data/repository/network_repo/itinerary_repository.dart';
import '../../../services/dio_client.dart';
import '../views/pdf_viewer_page_view.dart';

class PdfViewerPageController extends GetxController
    with StateMixin<PdfViewerPageView> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

  RxInt pageCount = 0.obs;
  // String? incomingFilePath;
  String? pdfPath;
  String? tourCode;
  RxString loadingString = RxString('');
  String? customerId;
  @override
  void onInit() {
    super.onInit();
    getpdf();
  }

  Future<void> getpdf() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      // incomingFilePath = Get.arguments[0] as String;
      customerId = Get.arguments[0] as String;
      tourCode = Get.arguments[1] as String;
      await loadData();

      change(null, status: RxStatus.success());
    }
  }

  Future<void> loadData() async {
    try {
      final ApiResponse<List<ItineraryModel>> response =
          await ItineraryRepository().getFixedItinerary(tourCode!);
      if (response.data != null) {
        pdfPath = response.data![0].pdfLink;
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  // Future<void> sharePdf() async {
  //   try {
  //     final Uri uri = Uri(
  //         scheme: 'sms',
  //         path: customerId,
  //         queryParameters: <String, dynamic>{'body': pdfPath});
  //     if (await canLaunch(uri.toString())) {
  //       await launch(uri.toString());
  //     } else {
  //       log('message');
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> sharePdf() async {
    log('message');
    try {
      try {
        loadingDialogue();
        final File downloadedPdf = await downloadPdfFile(pdfPath.toString());
        await sendPDFtoDash(downloadedPdf.path);
      } finally {
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

  Future<File> downloadPdfFile(String pdfUrl) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String filePath = '${appDocDir.path}/downloaded_pdf.pdf';
    final http.Response response = await http.get(Uri.parse(pdfUrl));

    if (response.statusCode == 200) {
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to download PDF file');
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
                    children: <Widget>[
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
