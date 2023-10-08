import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../data/models/network_models/lead_response_model.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_empty_screen.dart';
import '../../../widgets/custom_loading_screen.dart';
import '../controllers/responses_screen_controller.dart';

class ResponsesScreenView extends GetView<ResponsesScreenController> {
  const ResponsesScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final ResponsesScreenController controller =
        Get.put(ResponsesScreenController());
    return Scaffold(
      appBar: CustomAppBar(),
      body: controller.obx(
        onEmpty: const CustomEmptyScreen(label: 'No responses'),
        onLoading: const CustomLoadingScreen(),
        (ResponsesScreenView? state) => controller.responseModel.isEmpty
            ? const CustomEmptyScreen(label: 'No Responses Till Now')
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemCount: controller.responseModel.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildResponseTile(controller.responseModel[index]),
              ),
      ),
    );
  }
}

Widget buildResponseTile(LeadResponseModel leadsResponseModel) => Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  leadsResponseModel.callDate!.parseFromIsoDate().toDateTime(),
                  style: subheading3,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: getColorFromHex(depColor),
                ),
                child: Text(
                  leadsResponseModel.responseText.toString(),
                  style: subheading2.copyWith(color: Colors.white),
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ],
        ),
      ],
    );
