// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/network_models/tours_model.dart';
import '../../../data/repository/network_repo/tours_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../views/category_wise_leads_view.dart';

class CategoryWiseLeadsController extends GetxController
    with StateMixin<CategoryWiseLeadsView> {
  RxList<TourModel> toursData = <TourModel>[].obs;
  List<TourModel> tours = <TourModel>[];
  String? depID;
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

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      depID = Get.arguments as String;
      await loadTour();
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> loadTour() async {
    try {
      final ApiResponse<List<TourModel>> response =
          await ToursRepository().getAllToursInDepartment(depID.toString());
      log(response.message.toString());
      if (response.data != null || response.data!.isNotEmpty) {
        toursData.value = response.data!;
        tours = response.data!;
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      log(e.toString());
      change(null, status: RxStatus.empty());
    }
  }

  void onSearchTextChanged(String text) {
    // if (text.isNotEmpty) {
    //   toursData.value = tours
    //       .where((TourModel tour) =>
    //           tour.tourCode!.toLowerCase().contains(text.toLowerCase()))
    //       .toList();
    // } else {
    //   toursData.value = tours;
    // }
  }

  void onClickSingleLead(String? tourCode) =>
      Get.toNamed(Routes.FULL_LEADS, arguments: tourCode)!
          .whenComplete(() => loadData());
}
