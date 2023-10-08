// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/network_models/itinerary_model.dart';
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
  String? customerPhoneNumber;
  @override
  void onInit() {
    super.onInit();
    getpdf();
  }

  Future<void> getpdf() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      // incomingFilePath = Get.arguments[0] as String;
      customerPhoneNumber = Get.arguments[0] as String;
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

  Future<void> sharePdf() async {
    try {
      final Uri uri = Uri(
          scheme: 'sms',
          path: customerPhoneNumber,
          queryParameters: <String, dynamic>{'body': pdfPath});
      if (await canLaunch(uri.toString())) {
        await launch(uri.toString());
      } else {
        log('message');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
