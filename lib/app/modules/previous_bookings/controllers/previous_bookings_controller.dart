import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/network_models/custom_snapshot_model.dart';
import '../../../data/models/network_models/tours_model.dart';
import '../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../data/repository/network_repo/tours_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../views/previous_bookings_view.dart';

class PreviousBookingsController extends GetxController
    with StateMixin<PreviousBookingsView> {
  String? customerId;
  String? depID;
  GetStorage storage = GetStorage();
  List<String> tourNames = <String>[];

  RxList<CustomerSnapshotModel> snapShotsModel = <CustomerSnapshotModel>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    log('message');

    await loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      customerId = Get.arguments as String;
      depID = await storage.read('depID') as String;
      await loadSnapShots();
    } else {
      log('hkjk');
    }
  }

  Future<void> loadSnapShots() async {
    try {
      await CustomBookingRepo()
          .getSnapshots(customerId!)
          .then((ApiResponse<List<CustomerSnapshotModel>> res) async {
        log(res.message.toString());
        if (res.data != null) {
          snapShotsModel.value = res.data!;
          for (var i = 0; i < snapShotsModel.length; i++) {
            await getTours(tourIds: snapShotsModel[i].tourIds!.toList());
          }
          change(null, status: RxStatus.success());
        } else {
          log('jkml,');
          change(null, status: RxStatus.empty());
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getTours({required List<dynamic> tourIds}) async {
    try {
      await ToursRepository()
          .getAllToursInDepartment(depID.toString())
          .then((ApiResponse<List<TourModel>> res) {
        if (res.data != null) {
          for (final dynamic e in tourIds) {
            log('cvgbh ${res.data}');
            final TourModel defaultTourModel = TourModel(
              tourId: e.toString(), // Set appropriate default values here
              tourName: 'No tour found', // Set appropriate default values here
            );

            final TourModel tour = res.data!.firstWhere(
              (TourModel element) => element.tourId == e,
              orElse: () =>
                  defaultTourModel, // Return the default TourModel object
            );

            final String tourName = tour.tourName.toString();
            tourNames.add(tourName);
          }
          log('cvgbhki $tourNames');
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void onTapSingleSnapshot(String? shotId) =>
      Get.toNamed(Routes.SINGLE_SNAPSHOT, arguments: shotId);
}
