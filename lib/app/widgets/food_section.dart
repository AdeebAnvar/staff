import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../core/theme/style.dart';
import '../data/models/network_models/food_model.dart';
import '../modules/custom_booking/controllers/custom_booking_controller.dart';
import 'custom_text_form_field.dart';

class FoodSection extends StatelessWidget {
  const FoodSection({super.key, required this.controller});
  final CustomBookingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                              e, '${e.foodType} ${e.foodName}'))
                          .toList(),
                      searchable: true,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (List<FoodModel> values) {
                        controller.selectedFoodsForDays.clear();
                        controller.selectedFoods.clear();
                        controller.selectedFoodsForDays.addAll(values);
                        for (int i = 0; i < controller.days.value; i++) {
                          controller.foodPrice['Day ${i + 1}'] =
                              <String, int>{};
                        }
                      },
                      buttonIcon: const Icon(Icons.arrow_drop_down),
                      buttonText: const Text('Select Food type'),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
        Obx(() => controller.selectedFoodsForDays.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: controller.days.value,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int dayIndex) {
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: ActionChip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                label: Text('Day ${dayIndex + 1}'),
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 2,
                                    child: MultiSelectDialogField<FoodModel>(
                                      buttonIcon:
                                          const Icon(Icons.arrow_drop_down),
                                      buttonText: const Text('Select Food'),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      listType: MultiSelectListType.CHIP,
                                      searchable: true,
                                      separateSelectedItems: true,
                                      items: controller.selectedFoodsForDays
                                          .map((FoodModel e) => MultiSelectItem<
                                                  FoodModel>(e,
                                              '${e.foodType}  ${e.foodName}'))
                                          .toList(),
                                      onConfirm: (List<FoodModel> values) {
                                        final List<String> foodNames =
                                            <String>[];
                                        for (final FoodModel element
                                            in values) {
                                          controller.foodsForSingleDayName[
                                                  'Day ${dayIndex + 1}']!
                                              .add(
                                                  '${element.foodType} ${element.foodName}');
                                        }
                                        for (final FoodModel element
                                            in values) {
                                          foodNames.add(
                                              '${element.foodType} ${element.foodName}');
                                        }
                                        final List<Map<String, dynamic>>
                                            foodList =
                                            foodNames.map((String foodName) {
                                          return <String, String?>{
                                            'food_name': foodName,
                                            'food_qty': null,
                                          };
                                        }).toList();

                                        controller.itinerarySnapshots[
                                                'Day ${dayIndex + 1}']![
                                            'food'] = foodList;
                                        log(controller.itinerarySnapshots
                                            .toString());

                                        if (controller.selectedFoods[
                                                    'Day ${dayIndex + 1}'] !=
                                                null &&
                                            controller
                                                .selectedFoods[
                                                    'Day ${dayIndex + 1}']!
                                                .isNotEmpty) {
                                          controller.selectedFoods[
                                                  'Day ${dayIndex + 1}']!
                                              .clear();
                                        }

                                        log('ygbhkml, ${controller.selectedFoods}');
                                        controller.selectedFoods[
                                            'Day ${dayIndex + 1}'] = values;
                                      },
                                    ),
                                  ),
                                )),
                            const SizedBox(width: 5),
                          ],
                        ),
                        Obx(() => controller
                                        .selectedFoods['Day ${dayIndex + 1}'] !=
                                    null &&
                                controller.selectedFoods['Day ${dayIndex + 1}']!
                                    .isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller
                                        .selectedFoods['Day ${dayIndex + 1}']
                                        ?.length ??
                                    0,
                                itemBuilder: (BuildContext context, int index) {
                                  final FoodModel? food = controller
                                          .selectedFoods['Day ${dayIndex + 1}']
                                      ?[index];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                              '${food!.foodType} ${food.foodName}',
                                              style: subheading2),
                                        ),
                                      ),
                                      const Text('x'),
                                      Expanded(
                                        child: CustomTextFormField(
                                          keyboardType: TextInputType.number,
                                          labelText: 'Qty',
                                          onChanged: (String value) async {
                                            final List<
                                                Map<String,
                                                    dynamic>> foodList = controller
                                                            .itinerarySnapshots[
                                                        'Day ${dayIndex + 1}']![
                                                    'food']
                                                as List<Map<String, dynamic>>;
                                            for (final Map<String,
                                                dynamic> foodData in foodList) {
                                              if (foodData['food_name'] ==
                                                  '${food.foodType} ${food.foodName}') {
                                                foodData['food_qty'] = value;
                                                break;
                                              }
                                            }
                                            log(controller.itinerarySnapshots[
                                                    'Day ${dayIndex + 1}']
                                                .toString());

                                            final int count = int.parse(value);
                                            log('count $count');
                                            final String? price = controller
                                                .selectedFoods[
                                                    'Day ${dayIndex + 1}']![
                                                    index]
                                                .price;
                                            log('price $price');
                                            final int sum =
                                                int.parse(price.toString()) *
                                                    count;
                                            log('sum $sum');

                                            final FoodModel foodkey = controller
                                                    .selectedFoods[
                                                'Day ${dayIndex + 1}']![index];
                                            log('foodKey $foodkey');

                                            controller.foodPrice[
                                                    'Day ${dayIndex + 1}']?[
                                                foodkey.foodName
                                                    .toString()] = sum;
                                            log('food foods ${controller.selectedFoods}');
                                            // for (final element in controller.selectedFoods['Day ${dayIndex}']) {

                                            // }
                                            final List<Map<String, Object>>
                                                foodDescription =
                                                <Map<String, Object>>[
                                              <String, Object>{
                                                'foodType':
                                                    food.foodType.toString(),
                                                'foodName':
                                                    food.foodName.toString(),
                                                'value': value,
                                              },
                                            ];
                                            for (final Map<String,
                                                    Object> element
                                                in foodDescription) {
                                              final String day =
                                                  'Day ${dayIndex + 1}';
                                              final Object? meal =
                                                  element['foodType'];
                                              final String description =
                                                  'Get ready to have ${element['foodName']} as $meal for ${element['value']} pax';

                                              if (controller.foodsForItinerary
                                                  .containsKey(day)) {
                                                if (meal != null &&
                                                    description != null) {
                                                  controller
                                                      .foodsForItinerary[day]
                                                      ?.add(<String, String>{
                                                    meal.toString(): description
                                                  });
                                                }
                                              }
                                            }
                                            log('Food For Itinerary : ${controller.foodsForItinerary}');
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : const SizedBox())
                      ],
                    );
                  },
                ),
              )
            : const SizedBox()),
      ],
    );
  }
}
