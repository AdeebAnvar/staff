import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../widgets/custom_appbar.dart';

import '../../../widgets/custom_empty_screen.dart';
import '../../../widgets/custom_loading_screen.dart';
import '../../../widgets/response_section.dart';
import '../controllers/single_lead_controller.dart';

class SingleLeadView extends GetView<SingleLeadController> {
  const SingleLeadView({super.key});
  @override
  Widget build(BuildContext context) {
    final SingleLeadController controller = Get.put(SingleLeadController());
    return Scaffold(
        appBar: CustomAppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () => controller.onClickResponseHistory(
                  controller.leads[0].customerId.toString()),
              icon: Icon(
                Icons.history,
                color: getColorFromHex(depColor),
              ),
            ),
            const SizedBox(height: 50, width: 10),
          ],
        ),
        body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          onEmpty: const CustomEmptyScreen(label: 'empty'),
          (SingleLeadView? state) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(19.0),
              child: Column(
                children: <Widget>[
                  buildItem(
                      'Customer ID', controller.leads[0].customerId.toString()),
                  buildItem('Name', controller.leads[0].customerName),
                  buildItem('Tour Name', controller.leads[0].tourCode),
                  buildItem('Tour Code', controller.tourCode),
                  buildItem(
                      'created date',
                      controller.leads[0].createdAt
                          .toString()
                          .parseFromIsoDate()
                          .toDateTime()),
                  const SizedBox(height: 10),
                  buildItem('Vehicle', controller.leads[0].customerVehicle),
                  buildItem('Progress', controller.leads[0].customerProgress),
                  buildItem('Pax', controller.leads[0].customerPax.toString()),
                  buildItem('Source', controller.leads[0].customerSource),
                  buildItem('Category', controller.leads[0].customerCategory),
                  buildItem('Remarks', controller.leads[0].customerRemarks),
                  if (controller.leads[0].followUpDate == '')
                    const SizedBox()
                  else
                    buildItem(
                      'Scheduled Date',
                      controller.leads[0].followUpDate
                          .toString()
                          .parseFromIsoDate()
                          .toDateTime(),
                    ),
                  const SizedBox(height: 13),
                  TextButton.icon(
                    onPressed: () => controller.onClickEditCustomerDetails(),
                    icon: IconButton(
                      onPressed: () => controller.onClickEditCustomerDetails(),
                      icon: Icon(
                        Icons.edit,
                        color: getColorFromHex(depColor),
                      ),
                    ),
                    label: Text(
                      'Edit Customer Details',
                      style: TextStyle(
                        color: getColorFromHex(depColor),
                      ),
                    ),
                  ),
                  const Divider(endIndent: 60, indent: 60),
                  SizedBox(height: 8.h),
                  Obx(
                    () => controller.responseClicked.value
                        ? ResponseSection(controller: controller)
                        : buildButtons(),
                  )
                ],
              ),
            ),
          ),
        ));
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

  Widget buildButtons() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: 40.w,
              height: 06.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: getColorFromHex(depColor)),
                onPressed: () => controller.onClickBooking(),
                child: Text('Booking',
                    style: heading3.copyWith(color: Colors.white)),
              ),
            ),
            Container(
              width: 40.w,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              height: 06.h,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.orangeAccent),
                onPressed: () => controller.onMessageClicked(),
                icon: const Icon(Icons.message_rounded),
                label: Text('Message',
                    style: heading3.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 43),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: 40.w,
              height: 06.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: getColorFromHex(depColor)),
                onPressed: () => controller.onCickResponse(),
                child: Text('Response',
                    style: heading3.copyWith(color: Colors.white)),
              ),
            ),
            Container(
              width: 40.w,
              height: 06.h,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton.icon(
                onPressed: () => controller.onCallClicked(),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.green),
                icon: const Icon(Icons.call),
                label: Text('Call Now',
                    style: heading3.copyWith(color: Colors.white)),
              ),
            ),
          ],
        )
      ],
    );
  }
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
