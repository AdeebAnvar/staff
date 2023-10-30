import 'dart:developer';

import '../../../../data/models/network_models/food_model.dart';
import '../../../../data/models/network_models/tours_model.dart';
import '../../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../../services/dio_client.dart';
import '../../controllers/custom_booking_controller.dart';

class FoodFunction {
  CustomBookingController controller = CustomBookingController();

  Future<void> getFoodsInTour() async {
    try {
      controller.searchingFood.value = true;
      final String tourId = controller.tours
          .firstWhere((TourModel element) =>
              element.tourName == controller.selectedTourWithoutTransit.value)
          .tourId!;
      final ApiResponse<List<FoodModel>> res =
          await CustomBookingRepo().getFoods(tourId);

      if (res.data!.isNotEmpty) {
        controller.foodModel.value = res.data!;
        controller.searchingFood.value = false;
        for (int i = 0; i < controller.days.value; i++) {
          controller.selectedFoodsForTour['Day ${i + 1}'] = <FoodModel>[];
        }
        for (int i = 0; i < controller.days.value; i++) {
          controller.selectedFoods['Day ${i + 1}'] = <FoodModel>[];
        }
      } else {
        controller.searchingFood.value = false;
      }
    } catch (e) {
      controller.searchingFood.value = false;

      log('room $e');
    }
  }
}
