import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../data/models/network_models/field_staff_single_booking_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_empty_screen.dart';
import '../controllers/single_booking_details_controller.dart';

class SingleBookingDetailsView extends GetView<SingleBookingDetailsController> {
  const SingleBookingDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final SingleBookingDetailsController controller =
        Get.put(SingleBookingDetailsController());
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Booking Id  : ${controller.fieldStaffBookingModel?.bookingId!}',
          style: heading2.copyWith(color: getColorFromHex(depColor)),
        ),
      ),
      body: controller.obx((SingleBookingDetailsView? state) => controller
                  .fieldStaffSingleBookingModel ==
              null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomEmptyScreen(label: 'No Details'),
                ],
              ),
            )
          : Column(
              children: <Widget>[
                buildLabel(
                    label: 'Customer Name ',
                    data: controller.fieldStaffBookingModel?.customerName),
                const SizedBox(height: 10),
                buildLabel(
                    label: 'Tour Startig On ',
                    data: controller.fieldStaffBookingModel?.startDate
                        .toString()
                        .parseFromIsoDate()
                        .toDateTime()),
                const SizedBox(height: 10),
                buildLabel(
                    label: 'Tour End On ',
                    data: controller.fieldStaffBookingModel?.endDate
                        .toString()
                        .parseFromIsoDate()
                        .toDateTime()),
                const SizedBox(height: 30),
                Expanded(
                  child: Card(
                    shadowColor: getColorFromHex(depColor),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    elevation: 8,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: getColorFromHex(depColor)!, width: 3),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            controller.fieldStaffSingleBookingModel.length,
                        itemBuilder: (BuildContext context, int dayIndex) =>
                            Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            type: MaterialType.transparency,
                            child: ExpansionTileCard(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 8,
                                initialElevation: 8,
                                subtitle: Text('Click to view tasks',
                                    style: paragraph3),
                                title: Text('Day ${dayIndex + 1}',
                                    style: heading3),
                                children: <Widget>[
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller
                                        .fieldStaffSingleBookingModel[dayIndex]
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final List<Result> dayItem = controller
                                              .fieldStaffSingleBookingModel[
                                          dayIndex];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Text(
                                                  'Task ${index + 1} : ${dayItem[index].task}',
                                                  style: subheading1,
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  'status : ${dayItem[index].status}',
                                                  style: subheading2.copyWith(
                                                      color: dayItem[index]
                                                                  .status ==
                                                              'completed'
                                                          ? telecallerGreen
                                                              .withGreen(130)
                                                          : telecallerRed
                                                              .withRed(180)),
                                                ),
                                                const SizedBox(height: 10),
                                                if (dayItem[index].reason != '')
                                                  Text(
                                                    'reason : ${dayItem[index].reason}',
                                                    style: subheading2.copyWith(
                                                        color: dayItem[index]
                                                                    .status ==
                                                                'completed'
                                                            ? telecallerGreen
                                                                .withGreen(130)
                                                            : telecallerRed
                                                                .withRed(180)),
                                                  ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: CustomButton().showBlueButton(
                                                          onTap: () => controller
                                                              .completedTask(
                                                                  dayItem[index]
                                                                      .taskId),
                                                          isLoading: false,
                                                          label: 'Completed',
                                                          color: telecallerGreen
                                                              .withGreen(130)),
                                                    ),
                                                    Expanded(
                                                      child: CustomButton().showBlueButton(
                                                          onTap: () => controller
                                                              .notCompletedTask(
                                                                  dayItem[index]
                                                                      .taskId),
                                                          isLoading: false,
                                                          label:
                                                              'Not Completed',
                                                          color: telecallerRed
                                                              .withRed(180)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
    );
  }

  Padding buildLabel({String? data, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('$label :', style: subheading1),
          Text(data ?? '', style: subheading1),
        ],
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

  Widget buildCard(
      FieldStaffSingleBookingModel fieldStaffSingleBookingModel, int index) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
          child: Column(
            children: <Widget>[
              buildTitle(label: 'Day ${index + 1}', data: ''),
              buildTitle(
                  data: '',
                  label: ' fieldStaffSingleBookingModel.task.toString()'),
            ],
          ),
        ),
      ),
    );
  }
}

Padding buildTitle(
    {required String label, required String data, Color color = Colors.black}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10),
    child: Column(
      children: <Widget>[
        Text(
          label,
          textAlign: TextAlign.justify,
          style: subheading2.copyWith(
              overflow: TextOverflow.visible, color: color),
        ),
      ],
    ),
  );
}
