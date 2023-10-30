import 'dart:developer';
import 'dart:io' as io;

// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/network_models/tours_model.dart';
import '../../../data/repository/network_repo/tours_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../views/fixed_itineraries_view.dart';

class FixedItinerariesController extends GetxController
    with StateMixin<FixedItinerariesView> {
  String? depId;
  RxList<TourModel> toursData = <TourModel>[].obs;
  List<TourModel> toursDatas = <TourModel>[];
  RxString isFetchingItinerary = RxString('');
  RxString isFetchedItinerary = RxString('');
  String? cid;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());

    if (Get.arguments != null) {
      depId = Get.arguments[0] as String;
      cid = Get.arguments[1] as String;
      await loadTours();
    }
  }

  Future<void> loadTours() async {
    try {
      final ApiResponse<List<TourModel>> response =
          await ToursRepository().getAllToursInDepartment(depId.toString());
      if (response.data != null && response.data!.isNotEmpty) {
        toursData.value = response.data!;
        toursDatas = response.data!;

        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
        // Debug statement for duplicate value
        // tourPdfEmpty = false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> onClickViewItineraries(
      BuildContext context, String fileUrl, String tourCode) async {
    isFetchingItinerary.value = 'Itinerary Fetching....';

    try {
      await openDownloadedPDF(fileUrl, tourCode);

      // await downloadAndSavePDF(fileUrl, tourCode);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> downloadAndSavePDF(String fileUrl, String tourCode) async {
    try {
      final Dio dio = Dio();
      final io.Directory dir = await getApplicationDocumentsDirectory();
      final String filePath = '${dir.path}/$tourCode.pdf';

      await dio.download(fileUrl, filePath).then((dynamic value) async {});

      log('PDF file downloaded and saved at: $filePath');
    } catch (e) {
      log('Error downloading bookin file: $e');
    }
  }

  Future<void> openDownloadedPDF(String pdfLink, String tourCode) async {
    isFetchingItinerary.value =
        'Itinerary Fetched trying to open \n Please wait....';
    await Get.toNamed(Routes.PDF_VIEWER_PAGE,
            arguments: <dynamic>[cid, tourCode])!
        .whenComplete(() => loadData());
  }

  void onChangeSearchValue(String text) {
    if (text.isNotEmpty) {
      toursData.value = toursDatas
          .where((TourModel tour) =>
              tour.tourName!.toLowerCase().contains(text.toLowerCase()) ||
              tour.tourCode!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    } else {
      toursData.value = toursDatas;
    }
  }
}
