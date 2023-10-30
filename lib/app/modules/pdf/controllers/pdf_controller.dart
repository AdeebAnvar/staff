import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../services/dio_client.dart';

class PdfController extends GetxController {
  String? pdf;
  String? customerId;
  RxString loadingString = RxString('');
  RxBool isLoading = false.obs;
  String? amountPayable;
  String? advPayment;
  List<List<String>>? tasks;
  List<List<String>>? bookables;
  String? tourId;
  String? tourStartingDateTime;
  String? tourEndingDateTime;
  String? depId;
  String? branchId;
  String? filePath;
  String? adult;
  String? kid;
  String? infant;
  bool isPrposal = false;
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
      amountPayable = Get.arguments[2] as String;
      advPayment = Get.arguments[3] as String;
      tasks = Get.arguments[4] as List<List<String>>;
      bookables = Get.arguments[5] as List<List<String>>;
      tourId = Get.arguments[6] as String;
      tourStartingDateTime = Get.arguments[7] as String;
      tourEndingDateTime = Get.arguments[8] as String;
      depId = Get.arguments[9] as String;
      branchId = Get.arguments[10] as String;
      isPrposal = Get.arguments[11] as bool;
      adult = Get.arguments[12] as String;
      kid = Get.arguments[13] as String;
      infant = Get.arguments[14] as String;
      log(amountPayable.toString());
      log(advPayment.toString());
    }
  }

  Future<void> sharePdf() async {
    log('message');
    try {
      isLoading(true);
      log('krmvkfrk ${Get.arguments}');
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
          log('vfrfgvfb gf $isPrposal');

          await sendPDFtoDash(file.path).then((dynamic value) async {
            if (isPrposal == false) {
              await bookingTour(
                customerId.toString(),
                amountPayable.toString(),
                advPayment.toString(),
                tasks!,
                bookables!,
                tourId.toString(),
                tourStartingDateTime.toString(),
                tourEndingDateTime.toString(),
                depId.toString(),
                branchId.toString(),
                adult.toString(),
                kid.toString(),
                infant.toString(),
                filePath.toString(),
              );
            }
          });
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
          colorText: const Color.fromARGB(255, 218, 218, 218),
          forwardAnimationCurve: Curves.bounceIn,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Itinerary cant Sent',
        '',
        messageText: isPrposal
            ? const Text('')
            : Text('Customer Booked',
                style: subheading2.copyWith(color: Colors.white)),
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

  Future<void> bookingTour(
      String customerId,
      String amountPayable,
      String advPayment,
      List<List<String>> tasks,
      List<List<String>> bookables,
      String tourId,
      String tourStartingDateTime,
      String tourEndingDateTime,
      String depId,
      String branchId,
      String adults,
      String kids,
      String infnats,
      String filePath) async {
    try {
      loadingString.value = 'Booking the customer';
      final ApiResponse<Map<String, dynamic>> res =
          await CustomBookingRepo().customBooking(
        customerId: customerId,
        amountPayable: amountPayable,
        advPayment: advPayment,
        tasks: tasks,
        adult: adults,
        kid: kids,
        infant: infnats,
        bookables: bookables,
        tourId: tourId,
        tourStartingDate: tourStartingDateTime,
        tourEndingDate: tourEndingDateTime,
        depID: depId,
        branchId: branchId,
        filePath: pdf.toString(),
      );
      log(res.status.toString());
      log(res.message.toString());
      log(res.data.toString());
    } catch (e) {
      loadingString.value = "Can't booking the customer";
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
}
