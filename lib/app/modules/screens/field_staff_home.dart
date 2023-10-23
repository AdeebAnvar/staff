import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/style.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/string_utils.dart';
import '../../data/models/network_models/field_staff_model.dart';
import '../../widgets/custom_empty_screen.dart';
import '../home/controllers/home_controller.dart';

class FieldStaffHomeScreen extends StatelessWidget {
  const FieldStaffHomeScreen({super.key, required this.homeController});
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: homeController.onClickProfile,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      homeController.telecallerData[0].profileImage != '' &&
                              homeController.telecallerData[0].profileImage !=
                                  null
                          ? NetworkImage(
                              homeController.telecallerData[0].profileImage
                                  .toString(),
                            )
                          : null,
                  backgroundColor: getColorFromHex(depColor),
                  child: homeController.telecallerData[0].profileImage != '' &&
                          homeController.telecallerData[0].profileImage != null
                      ? const SizedBox()
                      : Text(
                          homeController.telecallerData[0].userName!
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 50, color: Colors.white),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20, width: 20),
          ],
        ),
        SizedBox(height: 20.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Hi',
                        style: TextStyle(
                          fontSize: 20,
                          color: getColorFromHex(depColor),
                        ),
                      ),
                      const SizedBox(
                        width: 130,
                      )
                    ],
                  ),
                  Text(
                    homeController.telecallerData[0].userName!.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'enigma',
                      fontSize: 40,
                      color: getColorFromHex(depColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Obx(() => homeController.fieldStaffBookingModel.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: homeController.fieldStaffBookingModel.length,
                itemBuilder: (BuildContext context, int index) => buildTile(
                    data: homeController.fieldStaffBookingModel[index],
                    onTap: () => homeController.onTapSingleBooking(
                        homeController.fieldStaffBookingModel[index])),
              )
            : const CustomEmptyScreen(label: 'No bookings Found')),
      ],
    );
  }

  Widget buildTile({FieldStaffBookingModel? data, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
          child: AnimatedBuilder(
              animation: homeController.animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                    scale: homeController.animation.value,
                    child: Column(
                      children: <Widget>[
                        buildTitle(
                            label: 'Customer Name',
                            data: data!.customerName.toString()),
                        buildTitle(
                            label: 'Booking ID',
                            data: data.bookingId.toString()),
                        buildTitle(
                            label: 'Tour Starting Date Time',
                            data: data.startDate
                                .toString()
                                .parseFromIsoDate()
                                .toDateTime()),
                        buildTitle(
                            label: 'Tour Ending Date Time',
                            data: data.endDate
                                .toString()
                                .parseFromIsoDate()
                                .toDateTime()),
                      ],
                    ));
              }),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.justify,
                style: subheading2.copyWith(
                    overflow: TextOverflow.visible, color: color),
              ),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              child: Center(
                child: Text(
                  data,
                  style: subheading2.copyWith(
                      overflow: TextOverflow.visible, color: color),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
