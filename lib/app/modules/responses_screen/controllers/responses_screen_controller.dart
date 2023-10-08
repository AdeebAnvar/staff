import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/network_models/lead_response_model.dart';
import '../../../data/repository/network_repo/leads_repository.dart';
import '../../../services/dio_client.dart';
import '../views/responses_screen_view.dart';

class ResponsesScreenController extends GetxController
    with StateMixin<ResponsesScreenView> {
  List<LeadResponseModel> responseModel = <LeadResponseModel>[];
  String? customerID;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      customerID = Get.arguments as String;
      responseModel = await getResponses(customerID!);
      change(null, status: RxStatus.success());
    }
  }

  Future<List<LeadResponseModel>> getResponses(String customerID) async {
    final ApiResponse<List<LeadResponseModel>> res =
        await LeadsRepository().getAllResponses(customerID);
    log('Adeeb rep d ${res.data}');
    log('Adeeb rep d ${res.message}');

    if (res.data != null) {
      return res.data!;
    } else {
      change(null, status: RxStatus.empty());
      throw Exception();
    }
  }
}
