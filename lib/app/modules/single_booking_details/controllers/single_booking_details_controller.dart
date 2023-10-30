import 'dart:developer';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/utils/constants.dart';
import '../../../data/models/network_models/field_staff_model.dart';
import '../../../data/models/network_models/field_staff_single_booking_model.dart';
import '../../../data/repository/network_repo/field_staff_booking_repo.dart';
import '../../../data/repository/network_repo/fieldstaff_booking_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../../../widgets/custom_toast.dart';
import '../views/single_booking_details_view.dart';

class SingleBookingDetailsController extends GetxController
    with StateMixin<SingleBookingDetailsView> {
  RxList<List<Result>> fieldStaffSingleBookingModel = <List<Result>>[].obs;
  FieldStaffBookingModel? fieldStaffBookingModel;
  RxString loadingString = RxString('');
  String reason = '';
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments[0] != null) {
      fieldStaffBookingModel = Get.arguments[0] as FieldStaffBookingModel;
      log(Get.arguments[0].toString());
      fieldStaffSingleBookingModel.value =
          await getFieldStaffBookings(fieldStaffBookingModel?.bookingId);
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<List<List<Result>>> getFieldStaffBookings(String? bookingId) async {
    final List<List<Result>> res =
        await FieldStaffBookingRepo().getFieldStaffSingleBookings(bookingId!);
    log(' rgvrgv $res');
    if (res != null) {
      return res;
    } else {
      return res;
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

  Future<void> completedTask(String taskId) async {
    try {
      loadingDialogue();
      loadingString.value = 'Sending completed task';

      await FieldStaffBookingsRepository()
          .completedTask(taskId: taskId)
          .then((ApiResponse<Map<String, dynamic>> value) {
        Future<dynamic>.delayed(const Duration(seconds: 2))
            .then((dynamic value) {
          loadingString.value = 'Marking as completed';
          loadData();
        });
      });
    } catch (e) {
      log(e.toString());
    } finally {
      Get.back();
    }
  }

  void notCompletedTask(String taskId) => reasonAskingDialogue(taskId);

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
                const SizedBox(height: 30),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DefaultTextStyle(
                          style: const TextStyle(color: Colors.black),
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

  void reasonAskingDialogue(String taskId) {
    Get.dialog(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Align(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Material(
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        helperText:
                            'Type the reason why the task is incomplete',
                        hintText: 'Reason',
                        fillColor: Colors.grey.shade100,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    onChanged: (String value) => reason = value,
                    keyboardType: TextInputType.multiline,
                    minLines: 15,
                    maxLines: 20,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => updateTask(taskId),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor:
                          getColorFromHex(depColor)!.withBlue(140)),
                  child: const Text('Update'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateTask(String taskId) async {
    if (reason.length <= 3 && reason == '') {
      CustomToastMessage().showCustomToastMessage('Add the reason properly');
    } else {
      Get.back();
      try {
        loadingDialogue();
        loadingString.value = 'Sending completed task';

        await FieldStaffBookingsRepository()
            .inCompletedTask(taskId: taskId, reason: reason)
            .then((ApiResponse<Map<String, dynamic>> value) {
          Future<dynamic>.delayed(const Duration(seconds: 2))
              .then((dynamic value) {
            loadingString.value = 'Marking as completed';
            loadData();
          });
        });
      } catch (e) {
        log(e.toString());
      } finally {
        Get.back();
      }
    }
  }
}
