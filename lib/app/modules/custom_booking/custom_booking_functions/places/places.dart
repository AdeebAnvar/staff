import 'dart:developer';

import '../../../../data/models/network_models/places_model.dart';
import '../../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../../services/dio_client.dart';
import '../../controllers/custom_booking_controller.dart';

class PlacesFunctions {
  CustomBookingController controller = CustomBookingController();
  Future<void> getPlacesInTour(String tourId) async {
    controller.isCheckingPlaces.value = true;

    try {
      final ApiResponse<List<PlacesModel>> response =
          await CustomBookingRepo().getPlaces(tourId);

      if (response.data != null && response.data!.isNotEmpty) {
        controller.placesModel.value = response.data!;

        controller.placeValues.clear();

        final Set<String> uniqueValues =
            <String>{}; // Use a set to track unique values
        final List<PlacesModel> places = controller.placesModel;

        for (final PlacesModel places in places) {
          if (places.placeName != null &&
              !uniqueValues.contains(places.placeName)) {
            uniqueValues.add(places.placeName!);

            controller.placeValues.add(places.placeName!);
          } else {}
        }
        controller.isCheckingPlaces.value = false;
      } else {
        controller.isCheckingPlaces.value = false;
      }
    } catch (e) {
      log(e.toString());
      controller.isCheckingPlaces.value = false;
    }
  }
}
