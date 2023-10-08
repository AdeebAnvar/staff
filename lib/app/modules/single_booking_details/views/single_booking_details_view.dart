import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_empty_screen.dart';
import '../controllers/single_booking_details_controller.dart';

class SingleBookingDetailsView extends GetView<SingleBookingDetailsController> {
  const SingleBookingDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final SingleBookingDetailsController controller =
        Get.put(SingleBookingDetailsController());
    return Scaffold(
      appBar: CustomAppBar(),
      body: controller.obx(
        (SingleBookingDetailsView? state) => controller
                .fieldStaffSingleBookingModel.isEmpty
            ? const CustomEmptyScreen(label: 'No Details')
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView(
                  children: <Widget>[
                    buildItem(
                        'Customer Name',
                        controller
                            .fieldStaffSingleBookingModel[0].customerName),
                    buildItem(
                        'Booking Date',
                        controller.fieldStaffSingleBookingModel[0].bookingDate
                            .toString()
                            .parseFromIsoDate()
                            .toDate()),
                    buildItem('Paid Amount',
                        controller.fieldStaffSingleBookingModel[0].amountPaid),
                    buildItem(
                        'Payable Amount',
                        controller
                            .fieldStaffSingleBookingModel[0].amountPayable),
                    const SizedBox(height: 30),
                    ActionChip(
                      autofocus: true,
                      backgroundColor: getColorFromHex(depColor),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text('View Document'),
                      labelStyle: subheading3.copyWith(color: Colors.white),
                      padding: const EdgeInsets.all(10),
                      onPressed: () => controller.onClickViewDocumnet(controller
                          .fieldStaffSingleBookingModel[0].travelItinerary),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Padding buildItem(String? label, String? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
              height: 40,
              width: 150,
              child: Text(
                '$label :',
                style: subheading1,
              )),
          SizedBox(
            height: 35,
            width: 35.w,
            child: Text(
              data.toString(),
              style: subheading2,
            ),
          ),
        ],
      ),
    );
  }
}
