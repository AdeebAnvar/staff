import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/create_itinerary_section.dart';
import '../../../widgets/custom_appbar.dart';

import '../../../widgets/custom_loading_screen.dart';
import '../../../widgets/custombooking_first_phase.dart';
import '../controllers/custom_booking_controller.dart';

class CustomBookingView extends GetView<CustomBookingController> {
  const CustomBookingView({super.key});
  @override
  Widget build(BuildContext context) {
    final CustomBookingController controller =
        Get.put(CustomBookingController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: const Text('Custom Booking'),
      ),
      body: controller.obx(
        onLoading: const CustomLoadingScreen(),
        (CustomBookingView? state) => GetBuilder<CustomBookingController>(
          init: CustomBookingController(),
          builder: (_) => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const RangeMaintainingScrollPhysics(
              parent: BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: <Widget>[
                  Obx(
                    () => controller.firstPhaseCompleted.value
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child:
                                CreateItinerarySection(controller: controller),
                          )
                        : buildFirstPhase(controller),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
