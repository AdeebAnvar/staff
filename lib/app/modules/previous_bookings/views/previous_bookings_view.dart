import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../controllers/previous_bookings_controller.dart';

class PreviousBookingsView extends GetView<PreviousBookingsController> {
  const PreviousBookingsView({super.key});
  @override
  Widget build(BuildContext context) {
    final PreviousBookingsController controller =
        Get.put(PreviousBookingsController());
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Custom Itinerary'),
      ),
      body: controller.obx(
        (PreviousBookingsView? state) => ListView.builder(
          itemCount: controller.snapShotsModel.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: InkWell(
                onTap: () => controller.onTapSingleSnapshot(
                    controller.snapShotsModel[index].shotId),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: ListTile(
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: getColorFromHex(depColor)),
                    subtitle: Text(
                        'created on : ${controller.snapShotsModel[index].created.toString().parseFromIsoDate().toDateTime()}',
                        style: subheading3),
                    title: Text(controller.tourNames[0],
                        style: subheading2.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
