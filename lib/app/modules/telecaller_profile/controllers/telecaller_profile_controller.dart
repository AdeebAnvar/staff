import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../data/models/network_models/leave_request_model.dart';
import '../../../data/models/network_models/telecaller_analytics_model.dart';
import '../../../data/models/network_models/telecaller_model.dart';
import '../../../data/repository/network_repo/telecaller_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../views/telecaller_profile_view.dart';

class TelecallerProfileController extends GetxController
    with StateMixin<TelecallerProfileView> {
  GlobalKey<FormState> formKey = GlobalKey();
  RxBool isExpanded = false.obs;
  RxBool isFullday = true.obs;
  RxBool isLoading = false.obs;
  String leaveStartDate = '';
  String leaveEndDate = '';
  String haldayLeaveDate = '';
  String reason = '';
  RxList<TeleCallerModel> telecallerData = <TeleCallerModel>[].obs;
  Rx<TeleCallerAnalytics> teleCallerAnalytics = TeleCallerAnalytics().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadData();
    log(' gruinjkm  $depColor');
  }

  void fullDayLeave() {
    isFullday.value = true;
  }

  void halfDayLeave() {
    isFullday.value = false;
  }

  void onClickedCheckLeaveStatus() =>
      Get.toNamed(Routes.LEAVE_STATUS_SCREEN)!.whenComplete(() => loadData());

  Future<void> logout() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut().then(
          (dynamic value) => Get.offAllNamed(Routes.LOGIN),
        );
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    try {
      final ApiResponse<List<TeleCallerModel>> res =
          await TelecallerRepository().getTelecallerDetails();
      log('fghujnkmiu./ ${res.message}');
      if (res.data != null) {
        telecallerData.value = res.data!;
        teleCallerAnalytics.value = await getTelecallerAnalytics();
        log('fghujnkm,l./');
        change(null, status: RxStatus.success());
      } else {
        log('fghujnkm,2./');
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      log('fghbuhiujk $e');
    }
  }

  Future<TeleCallerAnalytics> getTelecallerAnalytics() async {
    final ApiResponse<TeleCallerAnalytics> res =
        await TelecallerRepository().getTelecallerAnalyticsDetails();
    log('Adeeb rep d ${res.data}');
    log('Adeeb rep d ${res.message}');

    if (res.data != null) {
      return res.data!;
    } else {
      throw Exception();
    }
  }

  String? validateDate(String? value) =>
      DateTime.tryParse(value ?? '') != null ? null : 'please add date';

  String? validateField(String? value) =>
      GetUtils.isLengthLessOrEqual(value, 30)
          ? 'please add reason in minimum above 30 words'
          : null;

  Future<void> submitLeaveRequest() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final LeaveRequestModel leaveRequestModel = LeaveRequestModel(
          reason: reason,
          applyDate: leaveStartDate,
          returnDate: leaveEndDate,
          branchId: telecallerData[0].branchId,
          deptId: telecallerData[0].depId,
        );
        final ApiResponse<Map<String, dynamic>> res =
            await TelecallerRepository().requestLeave(leaveRequestModel);
        if (res.status == ApiResponseStatus.completed) {
          isLoading.value = false;
          Get.snackbar(
            'Leave Request Submitted',
            '',
            colorText: Colors.white,
            backgroundColor: getColorFromHex(depColor),
          );
        } else {
          Get.snackbar(
            'Leave Request Not Submitted',
            '',
            colorText: Colors.white,
            backgroundColor: getColorFromHex(depColor),
          );
          isLoading.value = false;
        }
      } catch (e) {
        isLoading.value = false;
        log(e.toString());
      }
    }
  }

  Future<void> onCallITSupport() async {
    const String number = '+918138949909';
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
