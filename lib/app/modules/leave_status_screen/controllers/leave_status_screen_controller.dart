import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/network_models/leave_status_model.dart';
import '../../../data/repository/network_repo/telecaller_repo.dart';
import '../../../services/dio_client.dart';
import '../views/leave_status_screen_view.dart';

class LeaveStatusScreenController extends GetxController
    with StateMixin<LeaveStatusScreenView> {
  RxList<LeaveStatusModel> leaveStatus = <LeaveStatusModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    try {
      final ApiResponse<List<LeaveStatusModel>> res =
          await TelecallerRepository().getLeaveStatus();
      if (res.status == ApiResponseStatus.completed) {
        if (res.data!.isNotEmpty) {
          leaveStatus.value = res.data!;
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
