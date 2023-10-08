import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../data/models/network_models/leave_status_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_empty_screen.dart';
import '../../../widgets/custom_loading_screen.dart';
import '../controllers/leave_status_screen_controller.dart';

class LeaveStatusScreenView extends GetView<LeaveStatusScreenController> {
  const LeaveStatusScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: controller.obx(
        onLoading: const CustomLoadingScreen(),
        onEmpty: const CustomEmptyScreen(label: 'No Leave Status Found'),
        (LeaveStatusScreenView? state) => Padding(
          padding: const EdgeInsets.all(24),
          child: ListView.builder(
            itemCount: controller.leaveStatus.length,
            itemBuilder: (BuildContext context, int index) =>
                buildCard(controller.leaveStatus[index]),
          ),
        ),
      ),
    );
  }

  Widget buildCard(LeaveStatusModel leaveStatus) => Card(
        margin: const EdgeInsets.all(15),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    leaveStatus.applyDate
                        .toString()
                        .parseFromIsoDate()
                        .toDateTime(),
                  ),
                  const Spacer(),
                  Text(
                    leaveStatus.status.toString(),
                    style: TextStyle(
                      color: leaveStatus.status.toString() == 'pending'
                          ? Colors.amber.shade900
                          : leaveStatus.status.toString() == 'approved'
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                leaveStatus.reason.toString(),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      );
}
