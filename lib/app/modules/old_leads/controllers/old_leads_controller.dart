import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../data/models/network_models/followup_model.dart';
import '../../../data/repository/network_repo/leads_repository.dart';
import '../../../data/repository/network_repo/search_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../views/old_leads_view.dart';

class OldLeadsController extends GetxController with StateMixin<OldLeadsView> {
  RxList<FollowUpModel> oldLead = <FollowUpModel>[].obs;
  // List<FollowUpModel> followupleads = <FollowUpModel>[];
  ScrollController scrollController = ScrollController();
  RxString pending = '0'.obs;
  RxBool isLoading = false.obs;
  FocusNode searchFocusNode = FocusNode();
  String? name;
  String? id;
  int page = 1;
  RxBool hasReachedEnd = false.obs;
  @override
  Future<void> onInit() async {
    loadInitialData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreData();
      } else {
        isLoading.value = false;
      }
    });
    super.onInit();
  }

  Future<void> loadInitialData() async {
    change(null, status: RxStatus.loading());
    page = 1;
    final List<FollowUpModel> initialData = await getAllOldLeads(page);
    oldLead.assignAll(initialData);
    change(null, status: RxStatus.success());
  }

  Future<void> loadMoreData() async {
    isLoading.value = true;
    if (!hasReachedEnd.value) {
      final List<FollowUpModel> newData = await getAllOldLeads(page + 1);
      if (newData.isEmpty) {
        isLoading.value = false;
        log('jkm,./');
      } else {
        log('jkm ytgh');
        isLoading.value = true;

        oldLead.addAll(newData);
        page++;
      }
    }
  }

  Future<List<FollowUpModel>> getAllOldLeads(int page) async {
    final ApiResponse<List<FollowUpModel>> res =
        await LeadsRepository().getAllOldLeads(page);
    log('Adeeb rep d ${res.data}');
    log('Adeeb rep d ${res.message}');

    if (res.data!.isNotEmpty) {
      final List<FollowUpModel> totalOldLeadsList = res.data!;

      pending.value = totalOldLeadsList.length.toString();
      isLoading.value = false;

      return totalOldLeadsList;
    } else {
      isLoading.value = false;
      log('kunnunun${isLoading.value}');
      return [];
    }
  }

  void onTapSingleLead(String id) {
    Get.toNamed(Routes.SINGLE_LEAD, arguments: id)!;
  }

  Future<void> searchById() async {
    try {
      Get.back();
      if (id != null && id != '') {
        await SearchRepository()
            .searchLeadinOldLeadsById(id.toString())
            .then((value) {
          if (value.data != null && value.data!.isNotEmpty) {
            oldLead.clear();
            oldLead.value = value.data!;
          } else {
            Get.snackbar('Not Found', '',
                backgroundColor: getColorFromHex(depColor),
                colorText: Colors.white);
          }
        });
      } else {
        Get.snackbar('Add Id', '',
            backgroundColor: getColorFromHex(depColor),
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;

      log(e.toString());
    }
  }

  Future<void> searchByName() async {
    try {
      Get.back();
      if (id != null && id != '') {
        await SearchRepository()
            .searchLeadinOldLeadsByName(name.toString())
            .then((value) {
          if (value.data != null && value.data!.isNotEmpty) {
            oldLead.clear();
            oldLead.value = value.data!;
          } else {
            Get.snackbar('Not Found', '',
                backgroundColor: getColorFromHex(depColor),
                colorText: Colors.white);
          }
        });
      } else {
        Get.snackbar('Add Name', '',
            backgroundColor: getColorFromHex(depColor),
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;

      log(e.toString());
    }
  }
}
