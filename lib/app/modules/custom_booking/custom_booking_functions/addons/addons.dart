import 'dart:developer';

import '../../../../data/models/network_models/addons_model.dart';
import '../../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../../services/dio_client.dart';
import '../../controllers/custom_booking_controller.dart';

class AdonFuntions {
  CustomBookingController controller = CustomBookingController();

  Future<void> getAddonsByPlaceId(
      String placeId, String dayKey, int dayIndex) async {
    try {
      controller.fetchingAddons['Day ${dayIndex + 1}'] = true;
      final ApiResponse<List<AddonsModel>> res =
          await CustomBookingRepo().getAddons(placeId);
      log('vdvf ${res.message}');
      if (res.data!.isNotEmpty) {
        controller.addonsModel[dayKey] = res.data!;
        controller.addonValues.clear();
        controller.fetchingAddons['Day ${dayIndex + 1}'] = false;
      }
    } catch (e) {
      controller.fetchingAddons['Day ${dayIndex + 1}'] = false;

      log('room $e');
    }
  }
}
