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
              .fieldStaffSingleBookingModel.isEmpty
          ? const CustomEmptyScreen(label: 'No Details')
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
                        itemCount: tasks.length,
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
                                children: [
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        tasks['Day ${dayIndex + 1}']?.length,
                                    itemBuilder: (context, index) => Card(
                                      child: Text(
                                          '${tasks['Day ${dayIndex + 1}']![index]}: ${tasks['Day ${dayIndex + 1}']![index]}'),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton().showBlueButton(
                                            onTap: () {},
                                            isLoading: false,
                                            label: 'Completed',
                                            color:
                                                telecallerGreen.withGreen(130)),
                                      ),
                                      Expanded(
                                        child: CustomButton().showBlueButton(
                                            onTap: () {},
                                            isLoading: false,
                                            label: 'Not Completed',
                                            color: telecallerRed.withRed(180)),
                                      ),
                                    ],
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
                  label: fieldStaffSingleBookingModel.task.toString()),
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

Map<String, List<Map<String, dynamic>>> tasks =
    <String, List<Map<String, dynamic>>>{
  'Day 1': <Map<String, dynamic>>[
    <String, dynamic>{'place': 'Pickup From Delhi AIRPORT'},
    <String, dynamic>{
      'addons': <String>['ddsvf', 'ffrgv']
    },
    <String, dynamic>{
      'activities': <String>['fvfs', 'da']
    },
    <String, dynamic>{
      'foods': <String>['dfds', 'adf']
    },
  ],
  'Day 2': <Map<String, dynamic>>[
    <String, dynamic>{'place': 'Pickup From Delhi AIRPORT'},
    <String, dynamic>{
      'addons': <String>['ddsvf', 'ffrgv']
    },
    <String, dynamic>{
      'activities': <String>['fvfs', 'da']
    },
    <String, dynamic>{
      'foods': <String>['dfds', 'adf']
    },
  ],
  'Day 3': <Map<String, dynamic>>[
    <String, dynamic>{'place': 'Pickup From gr AIRPORT'},
    <String, dynamic>{
      'addons': <String>['ddsvf', 'ffrgv']
    },
    <String, dynamic>{
      'activities': <String>['fvfs', 'da']
    },
    <String, dynamic>{
      'foods': <String>['dfds', 'adf']
    },
  ],
  'Day 4': <Map<String, dynamic>>[
    <String, dynamic>{'place': 'Pickup From rgr AIRPORT'},
    <String, dynamic>{
      'addons': <String>['ddsvf', 'ffrgv']
    },
    <String, dynamic>{
      'activities': <String>['fvfs', 'da']
    },
    <String, dynamic>{
      'foods': <String>['dfds', 'adf']
    },
  ],
  'Day 5': <Map<String, dynamic>>[
    <String, dynamic>{'place': 'Pickup grgrfgvf Delhi AIRPORT'},
    <String, dynamic>{
      'addons': <String>['ddsvf', 'ffrgv']
    },
    <String, dynamic>{
      'activities': <String>['fvfs', 'da']
    },
    <String, dynamic>{
      'foods': <String>['dfds', 'adf']
    },
  ],
  'Day 6': <Map<String, dynamic>>[
    <String, dynamic>{'place': 'Pickup From Delhi AIRPORT'},
    <String, dynamic>{
      'addons': <String>['ddsvf', 'ffrgv']
    },
    <String, dynamic>{
      'activities': <String>['fvfs', 'da']
    },
    <String, dynamic>{
      'foods': <String>['dfds', 'adf']
    },
  ],
};
