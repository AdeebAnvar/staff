import 'dart:developer';

import '../../../../data/models/network_models/activity_model.dart';
import '../../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../../services/dio_client.dart';
import '../../controllers/custom_booking_controller.dart';

class ActivityFunctions {
  CustomBookingController controller = CustomBookingController();

  Future<void> getActivitiesByPlaceId(
      String placeId, String dayKey, int dayIndex) async {
    if (controller.activityModel.containsKey(dayKey)) {
      controller.activityModel[dayKey]!.clear();
    }
    try {
      final ApiResponse<List<ActivityModel>> res =
          await CustomBookingRepo().getActivities(placeId);

      if (res.data!.isNotEmpty) {
        controller.activityModel[dayKey] = res.data!;
      }
    } catch (e) {
      log('room $e');
    }
  }
}
