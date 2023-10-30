import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/telecalling_icons_icons.dart';
import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../data/models/network_models/bookings_model.dart';
import '../../../widgets/custom_appBar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_loading_screen.dart';
import '../controllers/telecaller_profile_controller.dart';

class TelecallerProfileView extends GetView<TelecallerProfileController> {
  const TelecallerProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final TelecallerProfileController controller =
        Get.put(TelecallerProfileController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: const Text('Profile View'),
      ),
      body: controller.obx(
        onLoading: const CustomLoadingScreen(),
        (TelecallerProfileView? state) => ListView(
          padding: const EdgeInsets.all(25),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {},
                child: controller.telecallerData[0].profileImage != '' &&
                        controller.telecallerData[0].profileImage != null
                    ? Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              controller.telecallerData[0].profileImage
                                  .toString(),
                            ),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundColor: getColorFromHex(depColor),
                        child: Text(
                          controller.telecallerData[0].userName!
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 50, color: Colors.white),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
                child: Text(
                    controller.telecallerData[0].userName!.toUpperCase(),
                    style: heading2)),
            const SizedBox(height: 22),
            Center(
              child: Text(
                'Employee ID : ${controller.telecallerData[0].userCode}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Designation : ${controller.telecallerData[0].depName} ${controller.telecallerData[0].userType}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 60),
            if (controller.isTelecallingStaff.value)
              buildTile(
                label: 'Bookings',
                icon: const Icon(Icons.confirmation_num_rounded,
                    color: Colors.white),
                onTap: () {},
                children: <Widget>[buildTotalBookingEarnedSection()],
              ),
            const SizedBox(height: 10),
            if (controller.isTelecallingStaff.value)
              buildTile(
                label: 'Analytics',
                icon:
                    const Icon(TelecallingIcons.chart_box, color: Colors.white),
                children: <Widget>[buildTotalPointsEarnedSection()],
                onTap: () {},
              )
            else
              const SizedBox(),
            const SizedBox(height: 10),

            buildTile(
                label: 'Leave Request',
                icon: const Icon(Icons.edit_calendar_rounded,
                    color: Colors.white),
                onTap: () {},
                children: <Widget>[buildLeaveRequestTable()]),
            const SizedBox(height: 10),
            buildTile(
              children: <Widget>[buildRequestITsupportSection()],
              label: 'Request IT Support',
              icon: const Icon(Icons.computer_rounded, color: Colors.white),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            buildTile(
              children: <Widget>[
                IconButton(
                  onPressed: () => controller.logout(),
                  icon: const Icon(Icons.logout_outlined, color: Colors.white),
                ),
              ],
              label: 'Logout',
              icon: const Icon(Icons.logout_rounded, color: Colors.white),
              onTap: () {},
            ),
            // Spacer(),
            Obx(() {
              return Image.network(
                controller.telecallerData[0].depImage.toString(),
                height: 150,
              );
            })
          ],
        ),
      ),
    );
  }

  Widget buildTile(
      {required String label,
      required Widget icon,
      required void Function() onTap,
      String? trailing,
      required List<Widget> children}) {
    return ExpansionTileCard(
      colorCurve: Curves.bounceInOut,
      animateTrailing: true,
      baseColor: Colors.grey.shade400,
      borderRadius: BorderRadius.circular(18),
      duration: const Duration(milliseconds: 600),
      elevation: 4,
      expandedColor: getColorFromHex(depColor),
      initialElevation: 2,
      elevationCurve: Curves.bounceInOut,
      turnsCurve: Curves.bounceInOut,
      leading: icon,
      trailing: const Icon(Icons.arrow_drop_down, color: Colors.white),
      title: Text(
        trailing != null ? '$label ($trailing)' : label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      children: children,
    );
  }

  Padding buildTotalPointsEarnedSection() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          buildPointsTableRow(
            date: ':',
            points: controller.teleCallerAnalytics.value.calls.toString(),
            tourCode: 'Calls done',
          ),
          buildPointsTableRow(
            date: ':',
            points: controller.teleCallerAnalytics.value.followUps.toString(),
            tourCode: 'Follow ups',
          ),
          buildPointsTableRow(
            date: ':',
            points:
                controller.teleCallerAnalytics.value.targetPoints.toString(),
            tourCode: 'Target point',
          ),
          buildPointsTableRow(
            date: ':',
            points: controller.teleCallerAnalytics.value.points.toString(),
            tourCode: 'Points earned',
          ),
          buildPointsTableRow(
            date: ':',
            points: controller.teleCallerAnalytics.value.bookings.toString(),
            tourCode: 'Bookings',
          ),
        ],
      ),
    );
  }

  Padding buildPointsTableRow(
      {required String tourCode,
      required String date,
      required String points}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(tourCode,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          Text(date,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          Text(points,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Padding buildTotalBookingsSection(
      {required String tourCode,
      required String date,
      required String points}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(tourCode,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          Text(date,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          Text(points,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Padding buildTotalBookingEarnedSection() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.teleCallerBookings.length,
          itemBuilder: (BuildContext context, int index) {
            final BookingsModel data = controller.teleCallerBookings[index];
            return Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Card(
                elevation: 4,
                color: getColorFromHex(depColor),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Customer ID   : ${data.customerId}',
                              style: subheading2.copyWith(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Tour          : ${data.tourName}',
                              style: subheading2.copyWith(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              'Booking Date  : ${data.bookingDate.toString().parseFromIsoDate().toDatewithMonthFormat()}',
                              style: subheading2.copyWith(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Points earned : ${data.points}',
                              style: subheading2.copyWith(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget buildLeaveRequestTable() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: <Widget>[
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio<bool>(
                    activeColor: Colors.white,
                    value: true,
                    groupValue: controller.isFullday.value,
                    onChanged: (bool? value) {
                      controller.fullDayLeave();
                    },
                  ),
                  const Text(
                    'Full Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Radio<bool>(
                    activeColor: Colors.white,
                    value: false,
                    groupValue: controller.isFullday.value,
                    onChanged: (bool? value) {
                      controller.halfDayLeave();
                    },
                  ),
                  const Text(
                    'Half Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 10),
            Obx(() {
              return controller.isFullday.value
                  ? Row(
                      children: <Widget>[
                        Expanded(
                          child: CustomDatePickerField(
                            borderColor: Colors.white,
                            labelName: 'Starting Date',
                            validator: (String? value) =>
                                controller.validateDate(value),
                            onChange: (String value) =>
                                controller.leaveStartDate = value,
                            labelColor: Colors.white,
                            calanderIconColor: Colors.white,
                            hintText: 'Starting Date',
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'to',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: CustomDatePickerField(
                              borderColor: Colors.white,
                              calanderIconColor: Colors.white,
                              labelColor: Colors.white,
                              labelName: 'Ending Date',
                              validator: (String? value) =>
                                  controller.validateDate(value),
                              onChange: (String value) =>
                                  controller.leaveEndDate = value,
                              hintText: 'Ending Date'),
                        ),
                      ],
                    )
                  : CustomDatePickerField(
                      calanderIconColor: Colors.white,
                      labelColor: Colors.white,
                      borderColor: Colors.white,
                      labelName: 'Select Date',
                      validator: (String? value) =>
                          controller.validateDate(value),
                      onChange: (String value) =>
                          controller.haldayLeaveDate = value,
                      hintText: 'Select Date');
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ActionChip(
                  backgroundColor: getColorFromHex(depColor),
                  onPressed: () => controller.onClickedCheckLeaveStatus(),
                  visualDensity: VisualDensity.comfortable,
                  pressElevation: 10,
                  label: const Text(
                    'Check Leave Status >> ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                fillColor: Colors.white,
                filled: false,
                label: const Text(
                  'Request',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              validator: (String? value) => controller.validateField(value),
              onChanged: (String value) => controller.reason = value,
              maxLength: 500,
              maxLines: 15,
            ),
            const SizedBox(height: 10),
            CustomButton().showBlueButton(
              color: getColorFromHex(depColor)!,
              isLoading: controller.isLoading.value,
              onTap: () => controller.submitLeaveRequest(),
              label: 'Submit Request',
            )
          ],
        ),
      ),
    );
  }

  Widget buildRequestITsupportSection() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: GestureDetector(
        onTap: () => controller.onCallITSupport(),
        child: const Text(
          'Contact  :  +918138949909',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
