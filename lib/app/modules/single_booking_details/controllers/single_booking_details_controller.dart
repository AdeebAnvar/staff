import 'dart:developer';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/network_models/field_staff_single_booking_model.dart';
import '../../../data/repository/network_repo/fieldstaff_booking_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../views/single_booking_details_view.dart';

class SingleBookingDetailsController extends GetxController
    with StateMixin<SingleBookingDetailsView> {
  RxList<FieldStaffSingleBookingModel> fieldStaffSingleBookingModel =
      <FieldStaffSingleBookingModel>[].obs;
  String? bookingId;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      bookingId = Get.arguments as String;
      fieldStaffSingleBookingModel.value =
          await getFieldStaffBookings(bookingId);
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<List<FieldStaffSingleBookingModel>> getFieldStaffBookings(
      String? bookingId) async {
    final ApiResponse<List<FieldStaffSingleBookingModel>> res =
        await FieldStaffBookingRepo().getFieldStaffSingleBookings(bookingId!);

    if (res.data!.isNotEmpty) {
      return res.data!;
    } else {
      return res.data!;
    }
  }

  Future<void> onClickViewDocumnet(String? travelItinerary) async {
    // await downloadAndSavePDF(travelItinerary!)
    //     .then((value) => openDownloadedPDF());
  }

  void openDownloadedPDF(String filePath) =>
      Get.toNamed(Routes.PDF_VIEWER_PAGE, arguments: filePath)!
          .whenComplete(() => loadData());

  Future<void> downloadAndSavePDF(String fileUrl) async {
    final Dio dio = Dio();
    final String fileName = fileUrl.split('/').last;
    try {
      final io.Directory dir = await getApplicationDocumentsDirectory();
      final String filePath = '${dir.path}/$fileName.pdf';

      await dio.download(fileUrl, filePath);
      log('PDF file downloaded and saved at: $filePath');
    } catch (e) {
      log('Error downloading single file: $e');
    }
  }
}
