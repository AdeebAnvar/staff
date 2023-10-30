import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../data/models/network_models/leads_model.dart';
import '../../../data/repository/network_repo/leads_repository.dart';
import '../../../data/repository/network_repo/search_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../views/fresh_leads_view.dart';

class FreshLeadsController extends GetxController
    with StateMixin<FreshLeadsView> {
  RxList<LeadsModel> freshLeads = <LeadsModel>[].obs;
  // List<LeadsModel> followupleads = <LeadsModel>[];
  String? name;
  String? id;
  ScrollController scrollController = ScrollController();
  RxString pending = '0'.obs;
  RxBool isLoading = false.obs;
  FocusNode searchFocusNode = FocusNode();
  int page = 1;
  RxString searchErrorText = RxString('');
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
    final List<LeadsModel> initialData = await getAllFreshLeads(page);
    freshLeads.assignAll(initialData);
    change(null, status: RxStatus.success());
  }

  Future<void> loadMoreData() async {
    isLoading.value = true;
    if (!hasReachedEnd.value) {
      final List<LeadsModel> newData = await getAllFreshLeads(page + 1);
      if (newData.isEmpty) {
        hasReachedEnd.value = true;
        isLoading.value = false;
        log('jkm,./');
      } else {
        log('jkm ytgh');
        isLoading.value = false;

        freshLeads.addAll(newData);
        page++;
      }
    }
  }

  Future<List<LeadsModel>> getAllFreshLeads(int page) async {
    final ApiResponse<List<LeadsModel>> res =
        await LeadsRepository().getFreshLeads(page);
    log('Adeeb rep d ${res.data}');
    log('Adeeb rep d ${res.message}');

    if (res.data!.isNotEmpty) {
      final List<LeadsModel> totalFreshLeadsList = res.data!;

      pending.value = totalFreshLeadsList.length.toString();
      isLoading.value = false;

      return totalFreshLeadsList;
    } else {
      isLoading.value = false;
      log('kunnunun${isLoading.value}');
      return <LeadsModel>[];
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
            .searchLeadinFreshLeadsById(id.toString())
            .then((ApiResponse<List<LeadsModel>> value) {
          if (value.data != null && value.data!.isNotEmpty) {
            freshLeads.clear();
            freshLeads.value = value.data!;
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
            .searchLeadinFreshLeadsByName(name.toString())
            .then((ApiResponse<List<LeadsModel>> value) {
          if (value.data != null && value.data!.isNotEmpty) {
            freshLeads.clear();
            freshLeads.value = value.data!;
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
