import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/style.dart';
import '../../core/utils/constants.dart';
import '../modules/single_lead/controllers/single_lead_controller.dart';
import 'custom_button.dart';
import 'custom_date_picker.dart';
import 'custom_dropdown.dart';

class ResponseSection extends StatelessWidget {
  const ResponseSection({super.key, required this.controller});
  final SingleLeadController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    controller.responseClicked.value = false;
                  },
                  icon: Icon(Icons.arrow_back_ios_new,
                      color: getColorFromHex(depColor)))
            ],
          ),
          Form(
            key: controller.formKey,
            child: Column(
              children: <Widget>[
                // CustomDatePickerField(
                //     labelName: 'Date',
                //     validator: (String? value) =>
                //         controller.validateDate(value),
                //     onChange: (String value) =>
                //         controller.selectedDate.value = value,
                //     hintText: 'hintText'),
                // const SizedBox(height: 30),
                Obx(() {
                  return CustomDropDownButton(
                    errorText: controller.errorText.value,
                    value: controller.selectedProgress.value,
                    labelText: 'Select Progress',
                    dropdownValues: progress,
                    onChanged: (String? value) =>
                        controller.selectedProgress.value = value.toString(),
                  );
                }),
                const SizedBox(height: 30),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fillColor: Colors.black,
                    filled: false,
                    label: const Text(
                      'Response',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  validator: (String? value) =>
                      controller.validateResponse(value),
                  onChanged: (String value) =>
                      controller.response.value = value,
                  maxLength: 200,
                  maxLines: 10,
                ),
                CustomDatePickerField(
                    labelName: 'Follow Up Date and time',
                    isTime: true,
                    validator: (String? value) {
                      return null;
                    }, // controller.validateFollowUpDate(value),
                    onChange: (String value) =>
                        controller.selectedFollowUpDate.value = value,
                    hintText: 'hintText'),
                Obx(() {
                  if (controller.recordedCallAdded.value) {
                    return CustomButton().showGreyButton(
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          controller.isLoading.value = false;
                        },
                        label: 'Added recorded Call');
                  } else {
                    if (controller.selectedProgress.value !=
                            'Select Progress' &&
                        controller.selectedProgress.value != 'Not Answering' &&
                        controller.selectedProgress.value != 'Waste') {
                      return CustomButton().showBlueButton(
                          color: getColorFromHex(depColor)!,
                          isLoading: controller.isLoading.value,
                          onTap: () async {
                            await controller.fetchAudioRecorder();
                          },
                          label: 'Take recorded Call');
                    } else {
                      return const SizedBox();
                    }
                  }
                }),
                Text(
                  controller.recordedCallAdded.value ||
                          controller.errorText.value != ''
                      ? ''
                      : controller.audiofileErrorText.value,
                  style: TextStyle(color: telecallerRed),
                ),
                Obx(
                  () {
                    return CustomButton().showBlueButton(
                        color: getColorFromHex(depColor)!,
                        isLoading: controller.isloading.value,
                        onTap: () {
                          controller.onClickUpdateResponse();

                          if (controller.completedResponse.value) {
                            Get.back();
                          }
                        },
                        label: 'Update Response');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
