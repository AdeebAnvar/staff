import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../data/models/network_models/food_model.dart';
import '../modules/custom_booking/controllers/custom_booking_controller.dart';

class FoodSection extends StatelessWidget {
  const FoodSection({super.key, required this.controller});
  final CustomBookingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.foodModel.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 10),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MultiSelectDialogField<FoodModel>(
                      items: controller.foodModel
                          .map((FoodModel e) => MultiSelectItem<FoodModel>(
                              e, e.foodType.toString()))
                          .toList(),
                      searchable: true,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (List<FoodModel> values) {},
                      buttonIcon: const Icon(Icons.arrow_drop_down),
                      buttonText: const Text('Select Food type'),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
