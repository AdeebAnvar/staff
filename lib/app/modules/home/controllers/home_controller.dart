import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/utils/constants.dart';

import '../../../data/models/network_models/field_staff_model.dart';
import '../../../data/models/network_models/followup_model.dart';
import '../../../data/models/network_models/leads_model.dart';
import '../../../data/models/network_models/telecaller_analytics_model.dart';
import '../../../data/models/network_models/telecaller_model.dart';
import '../../../data/repository/network_repo/fieldstaff_booking_repo.dart';
import '../../../data/repository/network_repo/leads_repository.dart';
import '../../../data/repository/network_repo/telecaller_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../views/home_view.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin, StateMixin<HomeView> {
  late AnimationController animationController;
  late Animation<double> animation;
  RxList<TeleCallerModel> telecallerData = <TeleCallerModel>[].obs;
  RxList<FieldStaffBookingModel> fieldStaffBookingModel =
      <FieldStaffBookingModel>[].obs;
  RxList<LeadsModel> leadData = <LeadsModel>[].obs;
  RxList<FollowUpModel> followUps = <FollowUpModel>[].obs;
  RxList<FollowUpModel> oldLeads = <FollowUpModel>[].obs;
  Rx<TeleCallerAnalytics> teleCallerAnalytics = TeleCallerAnalytics().obs;
  GetStorage storage = GetStorage();
  @override
  Future<void> onInit() async {
    await loadData();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    super.onInit();
  }

  @override
  void onReady() {
    animationController.forward();
    super.onReady();
  }

  void onClickFollowUps() =>
      Get.toNamed(Routes.FOLLOW_UPS)!.whenComplete(() => loadData());

  void onClickFreshLeads() =>
      Get.toNamed(Routes.FRESH_LEADS)!.whenComplete(() => loadData());

  void onClickOldLeads() =>
      Get.toNamed(Routes.OLD_LEADS)!.whenComplete(() => loadData());
  void onClickProfile() {
    Get.toNamed(Routes.TELECALLER_PROFILE)!.whenComplete(() => loadData());
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());

    telecallerData.value = await getTelecallerData();
    depColor = telecallerData[0].depColor!;
    storage.write('depImage', telecallerData[0].depImage);
    teleCallerAnalytics.value = await getTelecallerAnalytics();
    fieldStaffBookingModel.value = (await getFieldStaffBookings())!;

    change(null, status: RxStatus.success());
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

  Future<List<TeleCallerModel>> getTelecallerData() async {
    final ApiResponse<List<TeleCallerModel>> res =
        await TelecallerRepository().getTelecallerDetails();

    if (res.data != null) {
      await storage.write('depID', res.data![0].depId);
      await storage.write('branchID', res.data![0].branchId);
      await storage.write('branchName', res.data![0].depName);
      await storage.write('telecaller_data', res.data![0]);
      return res.data!;
    } else {
      return res.data!;
    }
  }

  // Future<List<LeadsModel>> getLeadData() async {
  //   final ApiResponse<List<LeadsModel>> res =
  //       await LeadsRepository().getFreshLeads();
  //   log('Adeeb rep d ${res.data}');
  //   log('Adeeb rep d ${res.message}');

  //   if (res.data != null) {
  //     return res.data!;
  //   } else {
  //     throw Exception();
  //   }
  // }

  // Future<List<FollowUpModel>> getOldLeads() async {
  //   final ApiResponse<List<FollowUpModel>> res =
  //       await LeadsRepository().getAllOldLeads();
  //   log('Adeeb rep d ${res.data}');
  //   log('Adeeb rep d ${res.message}');

  //   if (res.data != null) {
  //     return res.data!;
  //   } else {
  //     throw Exception();
  //   }
  // }

  // Future<List<FollowUpModel>> getFollowUps() async {
  //   final ApiResponse<List<FollowUpModel>> res =
  //       await LeadsRepository().getAllFollowUpsLeads();
  //   log('Adeeb rep d ${res.data}');
  //   log('Adeeb rep d ${res.message}');

  //   if (res.data != null) {
  //     final DateTime today = DateTime.now();

  //     final List<FollowUpModel> totalFollowUpList = res.data!;
  //     final List<FollowUpModel> todayFollowUps = <FollowUpModel>[];

  //     for (final FollowUpModel followUPS in totalFollowUpList) {
  //       if (followUPS.followUpDate!.year <= today.year &&
  //           followUPS.followUpDate!.month <= today.month &&
  //           followUPS.followUpDate!.day <= today.day) {
  //         todayFollowUps.add(followUPS);
  //       }
  //     }
  //     return todayFollowUps;
  //   } else {
  //     throw Exception();
  //   }
  // }

  Future<List<FieldStaffBookingModel>?> getFieldStaffBookings() async {
    final ApiResponse<List<FieldStaffBookingModel>> res =
        await FieldStaffBookingRepo().getFieldStaffBookings();

    if (res.data != null) {
      return res.data!;
    } else {
      change(null, status: RxStatus.empty());
      return null;
    }
  }

  void onTapSingleBooking(FieldStaffBookingModel? fieldStaffBookingModel) =>
      Get.toNamed(Routes.SINGLE_BOOKING_DETAILS,
          arguments: <FieldStaffBookingModel?>[fieldStaffBookingModel]);
}
