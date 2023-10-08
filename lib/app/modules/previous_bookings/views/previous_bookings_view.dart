import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
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
      appBar: CustomAppBar(),
      body: controller.obx(
        (PreviousBookingsView? state) => ListView.builder(
          itemCount: controller.snapShotsModel.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                child: ListTile(
                  subtitle: Text(
                      controller.snapShotsModel[index].created
                          .toString()
                          .parseFromIsoDate()
                          .toDateTime(),
                      style: subheading3),
                  title: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.tourNames.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Text(controller.tourNames[index], style: subheading1),
                    ),
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
