// ignore_for_file: unnecessary_overrides, avoid_slow_async_io

import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/network_models/single_leads_model.dart';
import '../../../data/models/network_models/tours_model.dart';
import '../../../data/repository/network_repo/leads_repository.dart';
import '../../../data/repository/network_repo/tours_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../views/booking_screen_view.dart';

class BookingScreenController extends GetxController
    with StateMixin<BookingScreenView> {
  RxList<String> dropdownValues = RxList<String>(<String>['']);
  GetStorage storage = GetStorage();
  List<SingleLeadModel> leads = <SingleLeadModel>[].obs;
  String? leadId;
  bool tourPdfEmpty = true;
  String? leadName;
  RxBool isloading = false.obs;
  RxBool isLoading = false.obs;
  RxString selectedTourCode = RxString('');
  RxList<TourModel> toursData = <TourModel>[].obs;
  String? depID;
  String? fixedItyinerary;
  String? nameOFItinerary;
  RxList<String> downloadedPDFs = <String>[].obs;
  String? phone;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onClickFixedItinerary() async {
    isloading.value = true;
    log('message');
    Get.toNamed(Routes.FIXED_ITINERARIES, arguments: <dynamic>[depID, phone]);
    // if (selectedTourCode.value != null &&
    //     selectedTourCode.value != '' &&
    //     selectedTourCode.value.isNotEmpty) {
    //   try {
    //     final ApiResponse<List<ItineraryModel>> response =
    //         await ItineraryRepository()
    //             .getFixedItinerary(selectedTourCode.value);
    //     if (response.data != null) {
    //       fixedItyinerary = response.data![0].pdfLink;
    //       nameOFItinerary = response.data![0].tourPdf;

    //       await downloadAndSavePDF(fixedItyinerary!);
    //       CustomToastMessage().showCustomToastMessage('PDF Downloaded!');
    //     } else {
    //       CustomToastMessage().showCustomToastMessage(
    //           'No Itinearary found on ${selectedTourCode.value}');
    //     }
    //   } catch (e) {
    //     log(e.toString());
    //   }
    // } else {
    //   CustomToastMessage().showCustomToastMessage('Select a Tour Code First');
    // }
    // log('messa ${selectedTourCode.value}');
    isloading.value = false;
  }

  void onClickCustomBooking() => Get.toNamed(Routes.CUSTOM_BOOKING,
          arguments: <dynamic>[toursData, leadId, leadName])!
      .whenComplete(() => loadData());

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      leadName = Get.arguments[0] as String;
      leadId = Get.arguments[1] as String;
      phone = Get.arguments[2] as String;
      log('vuhuyu $phone');
      await loadLeadData(leadId.toString());
      depID = await storage.read('depID') as String;
      // await loadTour();
    }
    // fetchDownloadedPDFs();
  }

  Future<void> loadLeadData(String id) async {
    try {
      final ApiResponse<List<SingleLeadModel>> response =
          await LeadsRepository().getSingleLead(id);
      if (response.status == ApiResponseStatus.completed) {
        leads = response.data!;

        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> loadTour() async {
    try {
      final ApiResponse<List<TourModel>> response =
          await ToursRepository().getAllToursInDepartment(depID.toString());
      log(response.message.toString());
      if (response.data != null && response.data!.isNotEmpty) {
        toursData.value = response.data!;
        dropdownValues.clear();
        final Set<String> uniqueValues =
            <String>{}; // Use a set to track unique values
        uniqueValues.clear();

        for (final TourModel tour in toursData) {
          if (tour.tourCode != null &&
              !uniqueValues.contains(tour.tourCode) &&
              tour.tourPdf != '' &&
              tour.tourPdf != null) {
            uniqueValues.add(tour.tourCode!);
            dropdownValues.add(tour.tourCode!);
          } else {
            // Debug statement for duplicate value
            log('Duplicate tourCode found: ${tour.tourCode}');
            // tourPdfEmpty = false;
          }
        }

        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      log(e.toString());
      change(null, status: RxStatus.empty());
    }
  }

  // Future<void> fetchDownloadedPDFs() async {
  //   final io.Directory dir = await getApplicationDocumentsDirectory();
  //   final List<io.FileSystemEntity> files = io.Directory(dir.path).listSync();

  //   downloadedPDFs.clear();
  //   for (final io.FileSystemEntity file in files) {
  //     if (file is File && path.extension(file.path).toLowerCase() == '.pdf') {
  //       downloadedPDFs.add(file.path);
  //       log('fuc ${downloadedPDFs[0]}');
  //     }
  //   }
  // }

//   Future<void> onDeleteFile(io.File file) async {
//     log('start try');

//     try {
//       log('getting access to the file');

//       if (await file.exists()) {
//         log('gett in');

//         await file.delete().whenComplete(() async {
//           await fetchDownloadedPDFs();
//           change(null, status: RxStatus.success());
//           Get.back();
//         });
//       }
//     } catch (e) {
//       log('Error in getting access to the file cacth');
//     }
//   }
// //
  void onClickPreviousResponses() =>
      Get.toNamed(Routes.PREVIOUS_BOOKINGS, arguments: leadId);
}
