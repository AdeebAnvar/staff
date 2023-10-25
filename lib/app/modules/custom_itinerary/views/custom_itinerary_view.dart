import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_appbar.dart';
import '../controllers/custom_itinerary_controller.dart';

class CustomItineraryView extends StatelessWidget {
  CustomItineraryView({super.key});
  final CustomItineraryController controller =
      Get.put(CustomItineraryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: const Text('Custom Booking'),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const RangeMaintainingScrollPhysics(
              parent: BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
            ),
            child: Form(
              key: controller.formKey,
              child: const Column(),
            ),
          );
        }));
  }
}
