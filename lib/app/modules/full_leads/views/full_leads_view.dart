import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_empty_screen.dart';
import '../../../widgets/custom_loading_screen.dart';
import '../controllers/full_leads_controller.dart';

class FullLeadsView extends GetView<FullLeadsController> {
  const FullLeadsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: controller.obx(
        onEmpty: const CustomEmptyScreen(label: 'No Leads'),
        onLoading: const CustomLoadingScreen(),
        (FullLeadsView? state) => Obx(() {
          return controller.leadsData.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.leadsData.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10),
                            child: ListTile(
                              dense: true,
                              onTap: () => controller.onTapSingleLead(controller
                                  .leadsData[index].leadId
                                  .toString()),
                              title: Center(
                                child: Text(
                                  controller.leadsData[index].customerName
                                      .toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              leading: ActionChip(
                                label: Text(
                                  controller.leadsData[index].customerId
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                onPressed: () => controller.onTapSingleLead(
                                  controller.leadsData[index].leadId.toString(),
                                ),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                backgroundColor: getColorFromHex(depColor),
                              ),
                              trailing: Text(
                                controller.leadsData[index].customerProgress
                                    .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
              : const CustomEmptyScreen(label: 'No Leads');
        }),
      ),
    );
  }
}
