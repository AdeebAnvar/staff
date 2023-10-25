import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../data/models/network_models/single_snapshot_model.dart';
import '../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../data/repository/network_repo/snapshot_repo.dart';
import '../views/single_snapshot_view.dart';

class SingleSnapshotController extends GetxController
    with StateMixin<SingleSnapshotView> {
  RxString loadingString = RxString('');
  String? shotId;
  RxList<Result> snapResult = <Result>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();

    loadingDialogue();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    try {
      loadingString.value = 'Fetching Data';
      if (Get.arguments != null) {
        shotId = Get.arguments as String;
      }
      await loadSnapData();
      change(null, status: RxStatus.success());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchRooms() async {
    try {
      loadingString.value = 'Fetching Rooms';
      for (int i = 0; i < snapResult[0].day!; i++) {
        final List<Room> room = snapResult[0].data![i].room ?? <Room>[];
        final List<String> roomIds = <String>[];
        if (room.isNotEmpty) {
          for (final Room element in room) {
            roomIds.add(element.roomId!);
          }
        }
        await checkRoom(roomIds);
      }
    } catch (e) {}
  }

  Future<void> fetchVehicles() async {}

  Future<void> fetchFoods() async {}

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
                SizedBox(height: 30),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DefaultTextStyle(
                          style: TextStyle(color: Colors.black),
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

  Future<void> loadSnapData() async {
    try {
      CustomBookingRepo()
          .getSingleSnapshots(shotId!)
          .then((List<Result> res) async {
        log('mes $res');
        if (res != null) {
          snapResult.value = res;

          await fetchRooms();
        } else {
          change(null, status: RxStatus.empty());
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> checkRoom(List<String> roomIds) async {
    try {
      await SnapShotRepo().fetchRooms(roomIds);
    } catch (e) {}
  }
}
