import 'dart:developer';

import 'package:get/get.dart';

import '../../../../data/models/network_models/room_category_model.dart';
import '../../../../data/models/network_models/single_room_model.dart';
import '../../../../data/models/network_models/tours_model.dart';
import '../../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../../services/dio_client.dart';
import '../../controllers/custom_booking_controller.dart';
import '../tours/tours.dart';

class RoomFunction {
  CustomBookingController controller = CustomBookingController();
  Future<void> getRoomCategoriesFromApi(
      CustomBookingController controller) async {
    controller.isCheckingRoomCategory.value = true;
    controller.searchingRooms.value = true;
    final List<String> tourIds = <String>[];
    for (final TourModel element in controller.tours) {
      if (element.tourName!.trim() ==
          controller.selectedTourWithoutTransit.value.trim()) {
        tourIds.add(element.tourId!);
      }
    }
    try {
      final ApiResponse<List<RoomCategoryModel>> res =
          await CustomBookingRepo().getRoomCategory(tourIds);
      if (res.status == ApiResponseStatus.completed) {
        controller.roomCategoryModel.value = res.data!;
        controller.roomCategoryDropDown.clear();
        final Set<String> uniqueValues =
            <String>{}; // Use a set to track unique values
        uniqueValues.clear();
        log('1');
        for (final RoomCategoryModel room in controller.roomCategoryModel) {
          if (room.catId != null &&
              !uniqueValues.contains(room.catName.toString())) {
            log('2');
            uniqueValues.add(room.catName.toString());
            controller.roomCategoryDropDown.add(room.catName.toString());
          } else {
            log('3');
            // Debug statement for duplicate value
            // tourPdfEmpty = false;
            controller.searchingRooms.value = false;
          }
        }
        controller.isCheckingRoomCategory.value = false;
        controller.searchingRooms.value = false;
      } else {
        controller.isCheckingRoomCategory.value = false;
        controller.searchingRooms.value = false;
      }
    } catch (e) {
      log(e.toString());
      controller.isCheckingRoomCategory.value = false;
      controller.searchingRooms.value = false;
    }
  }

  Future<void> getRooms(
      List<String> roomtypes, List<String> roomCategories) async {
    controller.isGettingRooms.value = true;

    await TourFunctions()
        .checkToursNonTransit(
            roomCategories: roomCategories, roomTypes: roomtypes)
        .then((dynamic value) => controller.isGettingRooms.value = false);
  }

  Future<void> getRoomTypes() async {
    controller.checkingRoomTypes.value = true;
    controller.searchingRoomTypes.value = true;
    log('gjrjnijgjr');
    final List<int> roomIds = <int>[];
    final List<String> tourIds = <String>[];
    for (final TourModel tour in controller.tours) {
      if (tour.tourName!.trim() ==
          controller.selectedTourWithoutTransit.trim()) {
        tourIds.add(tour.tourId!);
      }
    }
    for (final RoomCategoryModel room in controller.roomCategoryModel) {
      if (room.catName!.trim() == controller.selectedRoomCategory.trim()) {
        roomIds.add(int.parse(room.catId.toString()));
      }
    }

    try {
      await CustomBookingRepo()
          .getRoomtypes(tourIds, roomIds)
          .then((ApiResponse<List<String>> res) {
        if (res.data != null && res.data!.isNotEmpty) {
          controller.roomTypes.value = res.data!;
          controller.roomTypesDropDown.clear();
          final Set<String> uniqueValues =
              <String>{}; // Use a set to track unique values
          uniqueValues.clear();

          for (final String room in controller.roomTypes) {
            if (room != null && !uniqueValues.contains(room)) {
              uniqueValues.add(room);
              controller.roomTypesDropDown.add(room);
              for (int i = 0; i < controller.nights.value; i++) {
                controller.selectedRoomes['Night ${i + 1}'] =
                    <SingleRoomModel>[];
              }
              // for (int i = 0; i < nights.value; i++) {
              //   roomPrice['Night ${i + 1}'] = {'': 0};
              // }
            } else {
              // Debug statement for duplicate value
              // tourPdfEmpty = false;
            }
          }
          controller.checkingRoomTypes.value = false;
          controller.searchingRoomTypes.value = false;
        } else {
          controller.checkingRoomTypes.value = false;

          controller.searchingRoomTypes.value = false;
        }
      });
    } catch (e) {
      controller.checkingRoomTypes.value = false;
      controller.searchingRoomTypes.value = false;

      log(e.toString());
    }
  }
}
