import 'dart:developer';

import 'package:get/get.dart';

import '../../../../data/models/network_models/checking_rooms_model.dart';
import '../../../../data/models/network_models/single_room_model.dart';
import '../../../../data/models/network_models/tours_model.dart';
import '../../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../../data/repository/network_repo/tours_repository.dart';
import '../../../../services/dio_client.dart';
import '../../../../widgets/custom_toast.dart';
import '../../controllers/custom_booking_controller.dart';

class TourFunctions {
  CustomBookingController controller = CustomBookingController();
  Future<List<String>> loadTours(String depId) async {
    try {
      List<String> tours = [];
      final ApiResponse<List<TourModel>> response =
          await ToursRepository().getAllToursInDepartment(depId);
      if (response.data != null && response.data!.isNotEmpty) {
        controller.tours.value = response.data!;
        final Set<String> uniqueValues =
            <String>{}; // Use a set to track unique values

        for (final TourModel tour in controller.tours) {
          if (tour.tourCode != null && !uniqueValues.contains(tour.tourCode)) {
            uniqueValues.add(tour.tourName!);
            log('gtbv v ${tour.tourId}');
            tours.add(tour.tourName!);
          } else {
            log('Duplicate tourCode found: ${tour.tourCode}');
          }
        }
        return tours;
      }
      return tours;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<void> checkToursNonTransit(
      {required List<String> roomCategories,
      required List<String> roomTypes}) async {
    if (controller.selectedTourWithoutTransit.isNotEmpty) {
      final TourModel matchingTour = controller.tours.firstWhere(
        (TourModel element) =>
            element.tourName == controller.selectedTourWithoutTransit.value,
        orElse: () =>
            TourModel(depId: ''), // Return null if no matching element is found
      );

      final List<int> roomcatId = <int>[];

      for (final String roomc in roomCategories) {
        log('grgthtf $roomCategories');

        roomcatId.add(int.parse(roomc.trimLeft()));
      }

      if (matchingTour != null) {
        final String toursId = matchingTour.tourId.toString();
        log('tethbe $toursId');
        final RoomsCheckingModel rm = RoomsCheckingModel(
            tourId: toursId, roomCategories: roomcatId, roomTypes: roomTypes);

        final ApiResponse<List<SingleRoomModel>> res =
            await CustomBookingRepo().checkRooms(rm);

        if (res.data!.isNotEmpty) {
          controller.roomModel.value = res.data!;

          // await checkVehicleAvailability();
        } else {
          controller.checkingAvailabilty.value = false;

          CustomToastMessage().showCustomToastMessage('No rooms found');
        }
      }
    }
  }

  Future<void> getToursIds() async {
    if (controller.selectedTourWithTransit.isNotEmpty) {}
    if (controller.selectedTourWithoutTransit.isNotEmpty) {
      final TourModel matchingTour = controller.tours.firstWhere(
        (TourModel element) =>
            element.tourName == controller.selectedTourWithoutTransit.value,
        orElse: () =>
            TourModel(depId: ''), // Return null if no matching element is found
      );

      if (matchingTour != null) {
        final String toursId = matchingTour.tourId.toString();
        log('tethbe $toursId');
        controller.toursIds.add(toursId);
      }
    }
  }
}
