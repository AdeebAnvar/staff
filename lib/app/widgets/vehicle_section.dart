import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../core/theme/style.dart';
import '../data/models/network_models/single_vehicle_model.dart';
import '../data/models/network_models/vehcile_category_model.dart';
import '../modules/custom_booking/controllers/custom_booking_controller.dart';
import 'create_itinerary_section.dart';
import 'custom_text_form_field.dart';

class VehicleSection extends StatelessWidget {
  const VehicleSection({super.key, required this.controller});
  final CustomBookingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        Text("*infants can't caluclate for vehicle",
            style: subheading2.copyWith(fontStyle: FontStyle.italic)),
        const SizedBox(height: 10),
        // Obx(
        //   () => controller.selectedVehicleTypes.isEmpty
        //       ? const SizedBox()
        //       : selectedVehicleCategoryList(controller),
        // ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Obx(() {
            return controller.tourSelected.value &&
                    controller.tourSelecting.value != true
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MultiSelectDialogField<String>(
                        items: controller.vehicleCtegoryDropDown
                            .map((String e) => MultiSelectItem<String>(e, e))
                            .toList(),
                        searchable: true,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        listType: MultiSelectListType.CHIP,
                        onSaved: (List<String>? value) {
                          log(value.toString());
                        },
                        onConfirm: (List<String> values) async {
                          controller.vehicleTypesDropDown.clear();

                          await controller.checkVehicleAvailability(
                              vehicleCatyegory: values);
                          log(controller.vehicleTypesDropDown.toString());
                          for (int i = 0; i < controller.days.value; i++) {
                            controller.selectedVehicles['Day ${i + 1}'] =
                                <String>[];
                          }
                          for (int i = 0; i < controller.days.value; i++) {
                            controller.vehicleQuantity['Day ${i + 1}'] =
                                <String, int>{};
                          }
                        },
                        buttonIcon: const Icon(Icons.arrow_drop_down),
                        buttonText: const Text('Select vehicle type'),
                      ),
                    ),
                  )
                : const SizedBox();
          }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Obx(() => controller.vehicleTypesDropDown.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MultiSelectDialogField<String>(
                      items: controller.vehicleTypesDropDown
                          .map((String e) => MultiSelectItem<String>(e, e))
                          .toList(),
                      searchable: true,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      listType: MultiSelectListType.CHIP,
                      onSaved: (List<String>? value) {
                        log(value.toString());
                      },
                      onConfirm: (List<String> values) async {
                        controller.selectedVehicleTypes.clear();
                        controller.selectedVehicleTypes.value = values;
                        controller.selectedVehicles.clear();

                        // await controller.checkVehicleAvailability(
                        //     vehicleCatyegory:
                        //         controller.selectedVehicleTypes);
                        for (int i = 0; i < controller.days.value; i++) {
                          controller.selectedVehicles['Day ${i + 1}'] =
                              <String>[];
                        }
                        for (int i = 0; i < controller.days.value; i++) {
                          controller.vehicleQuantity['Day ${i + 1}'] =
                              <String, int>{};
                        }
                      },
                      buttonIcon: const Icon(Icons.arrow_drop_down),
                      buttonText: const Text('Select vehicles'),
                    ),
                  ),
                )
              : const SizedBox()),
        ),
        Obx(() => controller.selectedVehicleTypes.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.days.value,
                  itemBuilder: (BuildContext context, int dayIndex) {
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ActionChip(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                label: Text(
                                  'Day ${dayIndex + 1}',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: MultiSelectDialogField<String>(
                                    items: controller.selectedVehicleTypes
                                        .map((String e) =>
                                            MultiSelectItem<String>(e, e))
                                        .toList(),
                                    searchable: true,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    listType: MultiSelectListType.CHIP,
                                    onSaved: (List<String>? value) {},
                                    onConfirm: (List<String> values) async {
                                      controller.selectedVehicles[
                                          'Day ${dayIndex + 1}'] = values;
                                      controller.vehiclestypForItinerary[
                                          'Day ${dayIndex + 1}'] = values;
                                      // controller.selectedVehicleForaday[
                                      //         'Day ${dayIndex + 1}'] =
                                      // (await controller
                                      //     .checkVehicleAvailability(
                                      //         vehicleCatyegory: controller
                                      //                 .selectedVehicles[
                                      //             'Day ${dayIndex + 1}']!))!;
                                    },
                                    buttonIcon:
                                        const Icon(Icons.arrow_drop_down),
                                    buttonText: const Text('Select vehicle'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(() => controller.selectedVehicles[
                                        'Day ${dayIndex + 1}'] !=
                                    null &&
                                controller
                                    .selectedVehicles['Day ${dayIndex + 1}']!
                                    .isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller
                                    .selectedVehicles['Day ${dayIndex + 1}']
                                    ?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  for (int i = 0; i < 20; i++) {
                                    controller
                                            .vehicleAmounts['Day ${i + 1}'] ??=
                                        <String, Map<String, bool>>{};
                                    controller.vehicleAmounts['Day ${i + 1}']?[
                                            controller.selectedVehicles[
                                                'Day ${i + 1}']]
                                        ?['Pickup price'] = false;
                                  }
                                  for (int i = 0; i < 20; i++) {
                                    controller
                                            .vehicleAmounts['Day ${i + 1}'] ??=
                                        <String, Map<String, bool>>{};
                                    controller.vehicleAmounts['Day ${i + 1}']?[
                                            controller.selectedVehicles[
                                                'Day ${i + 1}']]
                                        ?['Day tour price'] = false;
                                  }
                                  for (int i = 0; i < 20; i++) {
                                    controller
                                            .vehicleAmounts['Day ${i + 1}'] ??=
                                        <String, Map<String, bool>>{};
                                    controller.vehicleAmounts['Day ${i + 1}']?[
                                            controller.selectedVehicles[
                                                'Day ${i + 1}']]
                                        ?['Addon price'] = false;
                                  }
                                  for (int i = 0; i < 20; i++) {
                                    controller
                                            .vehicleAmounts['Day ${i + 1}'] ??=
                                        <String, Map<String, bool>>{};
                                    controller.vehicleAmounts['Day ${i + 1}']?[
                                            controller.selectedVehicles[
                                                'Day ${i + 1}']]
                                        ?['Dropoff price'] = false;
                                  }
                                  return Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                  controller.selectedVehicles[
                                                              'Day ${dayIndex + 1}']
                                                          ?[index] ??
                                                      'f',
                                                  style: subheading2),
                                            ),
                                          ),
                                          const Text('x'),
                                          Expanded(
                                            child: CustomTextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              labelText: 'Qty',
                                              onChanged: (String value) async {
                                                controller.vehicleQuantity[
                                                        'Day ${dayIndex + 1}']?[
                                                    controller.selectedVehicles[
                                                                'Day ${dayIndex + 1}']
                                                            ?[index] ??
                                                        ''] = int.parse(value);
                                                log('ITINERARY ${controller.vehiclesForItinerary}');
                                                controller.vehiclesForItinerary[
                                                        'Day ${dayIndex + 1}'] =
                                                    controller
                                                        .vehiclestypForItinerary[
                                                            'Day ${dayIndex + 1}']!
                                                        .map((String item) =>
                                                            '$value $item')
                                                        .toList();
                                                log('ITINERARY ${controller.vehiclestypForItinerary}');
                                                log('ITINERARY ${controller.vehiclesForItinerary}');

                                                log(controller.vehicleQuantity
                                                    .toString());
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 70,
                                      //   child: ListView.builder(
                                      //       physics:
                                      //           const BouncingScrollPhysics(),
                                      //       shrinkWrap: true,
                                      //       itemCount: 1,
                                      //       scrollDirection:
                                      //           Axis.horizontal,
                                      //       itemBuilder:
                                      //           (BuildContext context,
                                      //               int chekIndex) {
                                      //         return GetBuilder<
                                      //                 CustomBookingController>(
                                      //             id: chekIndex,
                                      //             builder: (_) {
                                      //               return Row(
                                      //                 children: <Widget>[
                                      //                   Obx(() {
                                      //                     return priceCheckBox(
                                      //                       label:
                                      //                           'Pickup price',
                                      //                       value: controller.vehicleAmounts['Day ${dayIndex + 1}']?[controller.selectedVehicles['Day ${dayIndex + 1}']?[index]]
                                      //                               ?[
                                      //                               'Pickup price'] ??
                                      //                           false,
                                      //                       onChanged:
                                      //                           (bool?
                                      //                               value) {
                                      //                         log('Day ${dayIndex + 1}');

                                      //                         if (value!) {
                                      //                           // Checkbox is checked
                                      //                           controller
                                      //                               .vehiclePrices
                                      //                               .add(controller.selectedVehicleForaday['Day ${dayIndex + 1}']?[chekIndex].pickupPrice);
                                      //                           // controller.isCheckedVehiclePickupPrice['Day ${dayIndex + 1}']
                                      //                           //     ?[
                                      //                           //     'Pickup price'] = true;
                                      //                           controller
                                      //                               .vehicleAmounts
                                      //                               .update(
                                      //                             'Day ${dayIndex + 1}',
                                      //                             (Map<String, Map<String, bool>>
                                      //                                 data) {
                                      //                               // Assuming you want to update a specific index in the nested map
                                      //                               data[controller.selectedVehicles['Day ${dayIndex + 1}']![index]]?['Pickup price'] = true;
                                      //                               return data;
                                      //                             },
                                      //                           );
                                      //                         } else {
                                      //                           // Checkbox is unchecked
                                      //                           controller
                                      //                               .vehiclePrices
                                      //                               .add(controller.selectedVehicleForaday['Day ${dayIndex + 1}']?[chekIndex].pickupPrice);
                                      //                           controller.isCheckedVehiclePickupPrice['Day ${dayIndex + 1}']
                                      //                               ?[
                                      //                               chekIndex] = false;
                                      //                           controller
                                      //                               .vehicleAmounts['Day ${dayIndex + 1}']
                                      //                               ?.remove('Pickup price');
                                      //                         }
                                      //                         controller
                                      //                             .update(<int>[
                                      //                           chekIndex
                                      //                         ]);
                                      //                         log(controller
                                      //                             .vehicleAmounts
                                      //                             .toString());
                                      //                       },
                                      //                     );
                                      //                   }),
                                      //                   Obx(() {
                                      //                     return priceCheckBox(
                                      //                       label:
                                      //                           'Day tour price',
                                      //                       value: controller.vehicleAmounts['Day ${dayIndex + 1}']?[controller.selectedVehicles['Day ${dayIndex + 1}']?[index]]
                                      //                               ?[
                                      //                               'Day tour price'] ??
                                      //                           false,
                                      //                       onChanged:
                                      //                           (bool?
                                      //                               value) {
                                      //                         if (value!) {
                                      //                           // Checkbox is checked
                                      //                           controller
                                      //                               .vehiclePrices
                                      //                               .add(controller.selectedVehicleForaday['Day ${dayIndex + 1}']?[chekIndex].daytourPrice);
                                      //                           controller.isCheckedVehicleDayTourPrice['Day ${dayIndex + 1}']
                                      //                               ?[
                                      //                               chekIndex] = true;
                                      //                           controller
                                      //                               .vehicleAmounts
                                      //                               .update(
                                      //                             'Day ${dayIndex + 1}',
                                      //                             (Map<String, Map<String, bool>>
                                      //                                 data) {
                                      //                               // Assuming you want to update a specific index in the nested map
                                      //                               data[controller.selectedVehicles['Day ${dayIndex + 1}']![index]]?['Day tour price'] = true;
                                      //                               return data;
                                      //                             },
                                      //                           );
                                      //                         } else {
                                      //                           // Checkbox is unchecked
                                      //                           controller
                                      //                               .vehiclePrices
                                      //                               .add(controller.selectedVehicleForaday['Day ${dayIndex + 1}']?[chekIndex].daytourPrice);
                                      //                           controller.vehicleAmounts['Day ${dayIndex + 1}']
                                      //                               ?[
                                      //                               controller.selectedVehicles['Day ${dayIndex + 1}']![index]]!['Day tour price'] = false;
                                      //                           controller
                                      //                               .vehicleAmounts['Day ${dayIndex + 1}']
                                      //                               ?.remove('Day tour price');
                                      //                         }
                                      //                         controller
                                      //                             .update(<int>[
                                      //                           chekIndex
                                      //                         ]);
                                      //                         log(controller
                                      //                             .vehicleAmounts
                                      //                             .toString());
                                      //                       },
                                      //                     );
                                      //                   }),
                                      //                   Obx(() {
                                      //                     return priceCheckBox(
                                      //                       label:
                                      //                           'Addon price',
                                      //                       value: controller.vehicleAmounts['Day ${dayIndex + 1}']?[controller.selectedVehicles['Day ${dayIndex + 1}']?[index]]
                                      //                               ?[
                                      //                               'Addon price'] ??
                                      //                           false,
                                      //                       onChanged:
                                      //                           (bool?
                                      //                               value) {
                                      //                         if (value!) {
                                      //                           // Checkbox is checked
                                      //                           controller
                                      //                               .vehiclePrices
                                      //                               .add(controller.selectedVehicleForaday['Day ${dayIndex + 1}']?[chekIndex].daytourPrice);
                                      //                           controller.isCheckedVehicleDayTourPrice['Day ${dayIndex + 1}']
                                      //                               ?[
                                      //                               chekIndex] = true;
                                      //                           controller.vehicleAmounts.update('Day ${dayIndex + 1}', (Map<String, Map<String, bool>>
                                      //                               data) {
                                      //                             // Assuming you want to update a specific index in the nested map
                                      //                             data[controller.selectedVehicles['Day ${dayIndex + 1}']![index]]?['Addon price'] =
                                      //                                 true;
                                      //                             return data;
                                      //                           }, ifAbsent:
                                      //                               () {
                                      //                             // If the key doesn't exist, create a new map with the entry
                                      //                             return {
                                      //                               controller.selectedVehicles['Day ${dayIndex + 1}']![index]: {
                                      //                                 'Addon price': true
                                      //                               }
                                      //                             };
                                      //                           });
                                      //                         } else {
                                      //                           // Checkbox is unchecked
                                      //                           controller
                                      //                               .vehiclePrices
                                      //                               .add(controller.selectedVehicleForaday['Day ${dayIndex + 1}']?[chekIndex].daytourPrice);
                                      //                           controller.vehicleAmounts['Day ${dayIndex + 1}']
                                      //                               ?[
                                      //                               controller.selectedVehicles['Day ${dayIndex + 1}']![index]]!['Addon price'] = false;
                                      //                           controller
                                      //                               .vehicleAmounts['Day ${dayIndex + 1}']
                                      //                               ?.remove('Addon price');
                                      //                         }
                                      //                         controller
                                      //                             .update(<int>[
                                      //                           chekIndex
                                      //                         ]);
                                      //                         log(controller
                                      //                             .vehicleAmounts
                                      //                             .toString());
                                      //                       },
                                      //                     );
                                      //                   }),
                                      //                   Obx(() {
                                      //                     return priceCheckBox(
                                      //                       label:
                                      //                           'Dropoff price',
                                      //                       value: controller.vehicleAmounts['Day ${dayIndex + 1}']?[controller.selectedVehicles['Day ${dayIndex + 1}']?[index]]
                                      //                               ?[
                                      //                               'Dropoff price'] ??
                                      //                           false,
                                      //                       onChanged:
                                      //                           (bool?
                                      //                               value) {
                                      //                         if (value!) {
                                      //                           // Checkbox is checked
                                      //                           controller
                                      //                               .vehiclePrices
                                      //                               .add(controller.selectedVehicleForaday['Day ${dayIndex + 1}']?[chekIndex].daytourPrice);
                                      //                           controller.isCheckedVehicleDayTourPrice['Day ${dayIndex + 1}']
                                      //                               ?[
                                      //                               chekIndex] = true;
                                      //                           controller.vehicleAmounts.update('Day ${dayIndex + 1}', (Map<String, Map<String, bool>>
                                      //                               data) {
                                      //                             // Assuming you want to update a specific index in the nested map
                                      //                             data[controller.selectedVehicles['Day ${dayIndex + 1}']![index]]?['Dropoff price'] =
                                      //                                 true;
                                      //                             return data;
                                      //                           }, ifAbsent:
                                      //                               () {
                                      //                             // If the key doesn't exist, create a new map with the entry
                                      //                             return {
                                      //                               controller.selectedVehicles['Day ${dayIndex + 1}']![index]: {
                                      //                                 'Dropoff price': true
                                      //                               }
                                      //                             };
                                      //                           });
                                      //                         } else {
                                      //                           // Checkbox is unchecked
                                      //                           controller
                                      //                               .vehiclePrices
                                      //                               .add(controller.selectedVehicleForaday['Day ${dayIndex + 1}']?[chekIndex].daytourPrice);
                                      //                           controller.vehicleAmounts['Day ${dayIndex + 1}']
                                      //                               ?[
                                      //                               controller.selectedVehicles['Day ${dayIndex + 1}']![index]]!['Dropoff price'] = false;
                                      //                           controller
                                      //                               .vehicleAmounts['Day ${dayIndex + 1}']
                                      //                               ?.remove('Dropoff price');
                                      //                         }
                                      //                         controller
                                      //                             .update(<int>[
                                      //                           chekIndex
                                      //                         ]);
                                      //                         log(controller
                                      //                             .vehicleAmounts
                                      //                             .toString());
                                      //                       },
                                      //                     );
                                      //                   }),
                                      //                 ],
                                      //               );
                                      //             });
                                      //       }),
                                      // )
                                    ],
                                  );
                                },
                              )
                            : const SizedBox()),
                      ],
                    );
                  },
                ),
              )
            : const SizedBox()),
      ],
    );
  }

  Widget selectedVehicleCategoryList(CustomBookingController controller) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 20),
        shrinkWrap: true,
        itemCount: controller.selectedVehicleTypes.length,
        itemBuilder: (BuildContext context, int index) {
          final String categoryId = controller.selectedVehicleTypes[index];
          final String? vehicleType = controller.vehicleCategoryModel
              .firstWhere(
                  (VehcileCategoryModel category) =>
                      category.catId == categoryId,
                  orElse: () =>
                      VehcileCategoryModel(catId: categoryId, catName: ''))
              .catName;

          return controller.selectedVehicleTypes.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Center(
                    child: Text(
                      vehicleType.toString(),
                      style: paragraph1.copyWith(color: Colors.black),
                    ),
                  ),
                )
              : const Text('');
        },
      ),
    );
  }

  Widget selectedVehicleModelList(CustomBookingController controller) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.selectedVehicleModel.length,
      itemBuilder: (BuildContext context, int index) {
        final String vehId =
            controller.selectedVehicleModel.values.elementAt(index);
        final SingleVehicleModel veh = controller.vehicleModel
            .firstWhere((SingleVehicleModel veh) => veh.vehicleId == vehId);

        return Card(
          child: Column(
            children: <Widget>[
              buildLabel(
                  label: 'Vehicle name', data: veh.vehicleName.toString()),
              buildLabel(
                  label: 'vehicle category', data: veh.categoryName.toString()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'For pax',
                        textAlign: TextAlign.justify,
                        style: subheading3.copyWith(
                          overflow: TextOverflow.visible,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CustomTextFormField(
                          keyboardType: TextInputType.phone,
                          initialValue:
                              controller.paxCountForVehicle[index] ?? '',
                          labelText: 'Pax',
                          onChanged: (String value) {
                            final String vehicleCategory =
                                veh.categoryName!.split(' ').first;
                            if (int.parse(value) > int.parse(vehicleCategory)) {
                              controller.countForPaxVehicleError[index] =
                                  "Can't add this much pax in this vehicle";
                            } else {
                              controller.paxCountForVehicle[index] = value;
                              controller.countForPaxVehicleError[index] = '';
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => controller.countForPaxVehicleError[index] != null
                    ? Text(
                        controller.countForPaxVehicleError[index].toString(),
                        style: const TextStyle(color: Colors.red),
                      )
                    : const Text(''),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Text('QTY', style: heading3),
              //       SizedBox(
              //         width: 40,
              //         height: 40,
              //         child: Column(
              //           children: <Widget>[
              //             Center(
              //               child: InkWell(
              //                 onTap: () {
              //                   final String? vehId = veh.vehicleId;
              //                   final int? vehicleQty =
              //                       controller.vehicleQTY[vehId];
              //                   if (vehId != null &&
              //                       vehicleQty != null &&
              //                       vehicleQty > 1) {
              //                     controller.vehicleQTY[vehId] = vehicleQty - 1;
              //                   }
              //                 },
              //                 child: const Icon(Icons.minimize),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //       Obx(() {
              //         return Text(
              //             controller.vehicleQTY[veh.vehicleId!].toString(),
              //             style: subheading1);
              //       }),
              //       IconButton(
              //         onPressed: () {
              //           final String? vehicleID = veh.vehicleId;
              //           final int? vehicleQty =
              //               controller.vehicleQTY[vehicleID];
              //           if (vehicleID != null &&
              //               vehicleQty != null &&
              //               vehicleQty > 0) {
              //             controller.vehicleQTY[vehicleID] = vehicleQty + 1;
              //           }
              //         },
              //         icon: const Icon(Icons.add),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
