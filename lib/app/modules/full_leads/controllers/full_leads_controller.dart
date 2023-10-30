import 'package:get/get.dart';

import '../../../data/models/network_models/single_leads_model.dart';
import '../../../routes/app_pages.dart';
import '../views/full_leads_view.dart';

class FullLeadsController extends GetxController
    with StateMixin<FullLeadsView> {
  RxList<SingleLeadModel> leadsData = <SingleLeadModel>[].obs;
  String? tourCode;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      tourCode = Get.arguments as String;
      await loadLeadData();
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> loadLeadData() async {
    try {
      // final ApiResponse<List<SingleLeadModel>> response =
      //     await LeadsRepository().getAllLeads(tourCode);
      // log(response.message.toString());
      // if (response.data != null || response.data!.isNotEmpty) {
      //   leadsData.value = response.data!;
      //   change(null, status: RxStatus.success());
      // } else {
      //   change(null, status: RxStatus.empty());
      // }
    } catch (e) {
      change(null, status: RxStatus.empty());
    }
  }

  void onTapSingleLead(String id) =>
      Get.toNamed(Routes.SINGLE_LEAD, arguments: id)!
          .whenComplete(() => loadData());
}
