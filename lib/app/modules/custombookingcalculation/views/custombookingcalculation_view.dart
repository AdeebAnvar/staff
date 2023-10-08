import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../widgets/custom_appBar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../controllers/custombookingcalculation_controller.dart';

class CustombookingcalculationView
    extends GetView<CustombookingcalculationController> {
  const CustombookingcalculationView({super.key});
  @override
  Widget build(BuildContext context) {
    final CustombookingcalculationController controller =
        Get.put(CustombookingcalculationController());
    return Scaffold(
      appBar: CustomAppBar(),
      body: controller.obx(
        (CustombookingcalculationView? state) => Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: <Widget>[
              buildLabel(
                  label: 'Tour',
                  data: controller.customItineraryDatas.tour.toString()),
              buildLabel(
                  label: 'Starting Date and Time',
                  data: controller.customItineraryDatas.tourStartingDateTime
                      .toString()
                      .parseFrom24Hours()
                      .toDateTime()),
              buildLabel(
                  label: 'Ending date Time',
                  data: controller.customItineraryDatas.tourEndingDateTime
                      .toString()
                      .parseFrom24Hours()
                      .toDateTime()),
              buildLabel(
                  label: 'Day',
                  data: controller.customItineraryDatas.days.toString()),
              buildLabel(
                  label: 'Nights',
                  data: controller.customItineraryDatas.nights.toString()),
              buildLabel(
                  label: 'Adults',
                  data: controller.customItineraryDatas.adults.toString()),
              buildLabel(
                  label: 'Kids',
                  data: controller.customItineraryDatas.kids.toString()),
              buildLabel(
                  label: 'Infants',
                  data: controller.customItineraryDatas.infants.toString()),
              const SizedBox(height: 50),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.customItineraryDatas.days,
                itemBuilder: (BuildContext context, int dayIndex) {
                  bool isData = true;
                  if (controller.vehicleQuantity['Day ${dayIndex + 1}'] !=
                          null ||
                      controller.roomPrice['Day ${dayIndex + 1}'] != null ||
                      controller.customItineraryDatas
                              .activitiesForSingleDay?['Day ${dayIndex + 1}'] !=
                          null ||
                      controller.customItineraryDatas
                              .foodForSingleDay?['Day ${dayIndex + 1}'] !=
                          null) {
                    isData = true;
                  } else {
                    isData = false;
                  }
                  if (isData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Day ${dayIndex + 1}', style: heading1),
                        const Divider(),
                        if (controller.vehicleQuantity['Day ${dayIndex + 1}'] !=
                            null)
                          Text('Vehicle', style: heading3)
                        else
                          const SizedBox(),
                        const SizedBox(height: 20),
                        if (controller.vehicleQuantity['Day ${dayIndex + 1}'] !=
                            null)
                          vehiclesForADay(controller, dayIndex)
                        else
                          const SizedBox(),
                        const Divider(),
                        const SizedBox(height: 30),
                        if (controller.roomPrice['Day ${dayIndex + 1}'] != null)
                          Text('Room', style: heading3),
                        const SizedBox(height: 20),
                        if (controller.roomPrice['Day ${dayIndex + 1}'] != null)
                          roomesForADay(controller, dayIndex),
                        const Divider(),
                        const SizedBox(height: 30),
                        if (controller.customItineraryDatas
                                    .activitiesForSingleDay?[
                                'Day ${dayIndex + 1}'] !=
                            null)
                          Text('Activity', style: heading3),
                        const SizedBox(height: 20),
                        if (controller.customItineraryDatas
                                    .activitiesForSingleDay?[
                                'Day ${dayIndex + 1}'] !=
                            null)
                          activityForADay(controller, dayIndex),
                        const Divider(),
                        const SizedBox(height: 30),
                        if (controller.customItineraryDatas
                                .foodForSingleDay?['Day ${dayIndex + 1}'] !=
                            null)
                          Text('Food', style: heading3),
                        const SizedBox(height: 20),
                        if (controller.customItineraryDatas
                                .foodForSingleDay?['Day ${dayIndex + 1}'] !=
                            null)
                          foodForAday(controller, dayIndex),
                        const SizedBox(height: 15),
                      ],
                    );
                  } else {
                    const Text('');
                  }
                  return null;
                },
              ),
              Obx(() {
                return CustomButton().showBlueButton(
                    onTap: () async {
                      controller.checkingAmount.value = true;
                      await checkAmount();
                    },
                    color: getColorFromHex(depColor)!,
                    isLoading: controller.checkingAmount.value,
                    label: 'Check Amount');
              }),
              Obx(() {
                return CustomButton().showBlueButton(
                    onTap: () => controller.generatePDF(),
                    isLoading: controller.generatingPDF.value, //88
                    label: 'Generate PDF',
                    color: getColorFromHex(depColor)!);
              }),
            ],
          ),
        ),
      ),
    );
  }

  ListView foodForAday(
      CustombookingcalculationController controller, int dayIndex) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.customItineraryDatas
          .foodForSingleDay?['Day ${dayIndex + 1}']?.length,
      itemBuilder: (BuildContext context, int foodIndex) {
        return GetBuilder<CustombookingcalculationController>(
            id: foodIndex,
            builder: (_) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      controller
                              .customItineraryDatas
                              .foodForSingleDay?['Day ${dayIndex + 1}']
                                  ?[foodIndex]
                              .foodName ??
                          '',
                      style: subheading1),
                  Text(
                      controller
                              .customItineraryDatas
                              .foodForSingleDay?['Day ${dayIndex + 1}']
                                  ?[foodIndex]
                              .foodCategory ??
                          '',
                      style: subheading1),
                  Text(
                      controller
                              .customItineraryDatas
                              .foodForSingleDay?['Day ${dayIndex + 1}']
                                  ?[foodIndex]
                              .foodType ??
                          '',
                      style: subheading1),
                  // Text(
                  //     'Food Price : ${controller.customItineraryDatas.foodForSingleDay?['Day ${dayIndex + 1}']?[foodIndex].price ?? ''}',
                  //     style: subheading1),
                  const SizedBox(height: 30),
                ],
              );
            });
      },
    );
  }

  ListView activityForADay(
      CustombookingcalculationController controller, int dayIndex) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.customItineraryDatas
            .activitiesForSingleDay?['Day ${dayIndex + 1}']?.length,
        itemBuilder: (BuildContext context, int activityIndex) {
          return GetBuilder<CustombookingcalculationController>(
              id: activityIndex,
              builder: (_) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        controller
                                .customItineraryDatas
                                .activitiesForSingleDay?['Day ${dayIndex + 1}']
                                    ?[activityIndex]
                                .activityName ??
                            '',
                        style: subheading1),
                    // Text(
                    //     controller
                    //             .customItineraryDatas
                    //             .activitiesForSingleDay?['Day ${dayIndex + 1}']
                    //                 ?[activityIndex]
                    //             .activityDes ??
                    //         '',
                    //     style: subheading1),
                    // Text(
                    //     'Activity Price : ${controller.customItineraryDatas.activitiesForSingleDay?['Day ${dayIndex + 1}']?[activityIndex].activityPrice ?? ''}',
                    //     style: subheading1),
                    CustomTextFormField(
                      keyboardType: TextInputType.phone,
                      // initialValue: (controller.customItineraryDatas.adults! +
                      //         controller.customItineraryDatas.kids!)
                      //     .toString(),
                      labelText: 'How many pax want this activty?',
                      onChanged: (String value) {
                        final String dayKey = 'Day ${dayIndex + 1}';
                        final num? activityPrice = controller
                            .customItineraryDatas
                            .activitiesForSingleDay?[dayKey]?[activityIndex]
                            .activityPrice;

                        if (activityPrice != null) {
                          final Map<num?, String> activityAmountForDay =
                              controller.activityAmount[dayKey] ??
                                  <num?, String>{};

                          activityAmountForDay[activityPrice] = value;

                          controller.activityAmount[dayKey] =
                              activityAmountForDay;

                          controller.update(<int>[activityIndex]);
                          log(controller.activityAmount.toString());
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              });
        });
  }

  ListView roomesForADay(
      CustombookingcalculationController controller, int dayIndex) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.customItineraryDatas
            .roomsForSingleDay?['Day ${dayIndex + 1}']?.length,
        itemBuilder: (BuildContext context, int roomIndex) {
          return GetBuilder<CustombookingcalculationController>(
              id: roomIndex,
              builder: (_) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        controller
                                .customItineraryDatas
                                .roomsForSingleDay?['Day ${dayIndex + 1}']
                                    ?[roomIndex]
                                .roomBuilding ??
                            '',
                        style: subheading1),
                    Text(
                        controller
                                .customItineraryDatas
                                .roomsForSingleDay?['Day ${dayIndex + 1}']
                                    ?[roomIndex]
                                .roomCategory ??
                            '',
                        style: subheading1),
                    Text(
                        'Room Number : ${controller.customItineraryDatas.roomsForSingleDay?['Day ${dayIndex + 1}']?[roomIndex].roomNumber ?? ''}',
                        style: subheading1),
                    // Text(
                    //     'Room Price : ${controller.customItineraryDatas.roomsForSingleDay?['Day ${dayIndex + 1}']?[roomIndex].roomPrice ?? ''}',
                    //     style: subheading1),
                    const SizedBox(height: 30),
                  ],
                );
              });
        });
  }

  ListView vehiclesForADay(
      CustombookingcalculationController controller, int dayIndex) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.vehicleQuantity['Day ${dayIndex + 1}']?.length,
        itemBuilder: (BuildContext context, int vehicleIndex) {
          return GetBuilder<CustombookingcalculationController>(
              id: vehicleIndex,
              builder: (_) {
                final String? key = controller
                    .vehicleQuantity['Day ${dayIndex + 1}']?.keys
                    .elementAt(vehicleIndex);
                final int? qty =
                    controller.vehicleQuantity['Day ${dayIndex + 1}']?[key];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(key ?? '', style: subheading1),
                    Text('Qty $qty', style: subheading1),
                    CheckboxListTile(
                      title: const Text('Addon Price'),
                      dense: true,

                      selectedTileColor: Colors.blueAccent,
                      activeColor: getColorFromHex(depColor),
                      // subtitle: Text(
                      //     controller
                      //             .customItineraryDatas
                      //             .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                      //                 ?[vehicleIndex]
                      //             .addonPrice ??
                      //         '',
                      //     style: subheading2),
                      value: controller.isCheckedVehicleAddonPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] ??
                          false,
                      onChanged: (bool? value) {
                        if (value!) {
                          final String? price = controller
                              .customItineraryDatas
                              .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                                  ?[vehicleIndex]
                              .addonPrice;
                          final int pric = int.parse(price!.trim());
                          final int tot = pric * qty!;
                          // Checkbox is checked
                          controller.vehiclePrices.add(tot.toString());
                          controller.isCheckedVehicleAddonPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] = true;
                          controller.vehicleAmounts
                              .update('Day ${dayIndex + 1}',
                                  (Map<String, String> data) {
                            return <String, String>{
                              ...data,
                              'Addon Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}':
                                  controller
                                          .customItineraryDatas
                                          .vehiclesForSingleDay?[
                                              'Day ${dayIndex + 1}']
                                              ?[vehicleIndex]
                                          .addonPrice ??
                                      ''
                            };
                          }, ifAbsent: () {
                            return <String, String>{
                              'Addon Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}':
                                  controller
                                          .customItineraryDatas
                                          .vehiclesForSingleDay?[
                                              'Day ${dayIndex + 1}']
                                              ?[vehicleIndex]
                                          .addonPrice ??
                                      ''
                            };
                          });
                        } else {
                          // Checkbox is unchecked
                          final String? price = controller
                              .customItineraryDatas
                              .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                                  ?[vehicleIndex]
                              .addonPrice;
                          final int pric = int.parse(price!.trim());
                          final int tot = pric * qty!;
                          // Checkbox is checked
                          controller.vehiclePrices.remove(tot.toString());

                          controller.isCheckedVehicleAddonPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] = false;
                          controller.vehicleAmounts['Day ${dayIndex + 1}']?.remove(
                              'Addon Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}');
                        }
                        controller.update(<int>[vehicleIndex]);
                        log(controller.vehicleAmounts.toString());
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Daytour Price'),
                      dense: true,

                      selectedTileColor: Colors.blueAccent,
                      activeColor: getColorFromHex(depColor),
                      // subtitle: Text(
                      //     controller
                      //             .customItineraryDatas
                      //             .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                      //                 ?[vehicleIndex]
                      //             .daytourPrice ??
                      //         '',
                      //     style: subheading2),
                      value: controller.isCheckedVehicleDayTourPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] ??
                          false,
                      onChanged: (bool? value) {
                        if (value!) {
                          // Checkbox is checked
                          // Checkbox is unchecked
                          final String? price = controller
                              .customItineraryDatas
                              .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                                  ?[vehicleIndex]
                              .addonPrice;
                          final int pric = int.parse(price!.trim());
                          final int tot = pric * qty!;

                          controller.vehiclePrices.add(tot.toString());
                          controller.isCheckedVehicleDayTourPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] = true;
                          controller.vehicleAmounts
                              .update('Day ${dayIndex + 1}',
                                  (Map<String, String> data) {
                            return <String, String>{
                              ...data,
                              'DayTour Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}':
                                  controller
                                          .customItineraryDatas
                                          .vehiclesForSingleDay?[
                                              'Day ${dayIndex + 1}']
                                              ?[vehicleIndex]
                                          .daytourPrice ??
                                      ''
                            };
                          }, ifAbsent: () {
                            return <String, String>{
                              'DayTour Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}':
                                  controller
                                          .customItineraryDatas
                                          .vehiclesForSingleDay?[
                                              'Day ${dayIndex + 1}']
                                              ?[vehicleIndex]
                                          .daytourPrice ??
                                      ''
                            };
                          });
                        } else {
                          // Checkbox is unchecked
                          final String? price = controller
                              .customItineraryDatas
                              .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                                  ?[vehicleIndex]
                              .addonPrice;
                          final int pric = int.parse(price!.trim());
                          final int tot = pric * qty!;

                          controller.vehiclePrices.remove(tot.toString());
                          controller.isCheckedVehicleDayTourPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] = false;
                          controller.vehicleAmounts['Day ${dayIndex + 1}']?.remove(
                              'DayTour Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}');
                        }
                        controller.update(<int>[vehicleIndex]);
                        log(controller.vehicleAmounts.toString());
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('DropOff Price'),
                      dense: true,

                      selectedTileColor: Colors.blueAccent,
                      activeColor: getColorFromHex(depColor),
                      // subtitle: Text(
                      //     controller
                      //             .customItineraryDatas
                      //             .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                      //                 ?[vehicleIndex]
                      //             .dropoffPrice ??
                      //         '',
                      //     style: subheading2),
                      value: controller.isCheckedVehicleDropOffPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] ??
                          false,
                      onChanged: (bool? value) {
                        if (value!) {
                          log('bhjkm');
                          // Checkbox is checked
                          final String? price = controller
                              .customItineraryDatas
                              .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                                  ?[vehicleIndex]
                              .addonPrice;
                          final int pric = int.parse(price!.trim());
                          final int tot = pric * qty!;

                          controller.vehiclePrices.add(tot.toString());
                          controller.isCheckedVehicleDropOffPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] = true;
                          controller.vehicleAmounts
                              .update('Day ${dayIndex + 1}',
                                  (Map<String, String> data) {
                            return <String, String>{
                              ...data,
                              'DropOff Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}':
                                  controller
                                          .customItineraryDatas
                                          .vehiclesForSingleDay?[
                                              'Day ${dayIndex + 1}']
                                              ?[vehicleIndex]
                                          .dropoffPrice ??
                                      ''
                            };
                          }, ifAbsent: () {
                            return <String, String>{
                              'DropOff Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}':
                                  controller
                                          .customItineraryDatas
                                          .vehiclesForSingleDay?[
                                              'Day ${dayIndex + 1}']
                                              ?[vehicleIndex]
                                          .dropoffPrice ??
                                      ''
                            };
                          });
                        } else {
                          log('bhjkm');
                          // Checkbox is unchecked
                          final String? price = controller
                              .customItineraryDatas
                              .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                                  ?[vehicleIndex]
                              .addonPrice;
                          final int pric = int.parse(price!.trim());
                          final int tot = pric * qty!;

                          controller.vehiclePrices.remove(tot.toString());
                          controller.isCheckedVehicleDropOffPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] = false;
                          controller.vehicleAmounts['Day ${dayIndex + 1}']?.remove(
                              'DropOff Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}');
                        }
                        controller.update(<int>[vehicleIndex]);
                        log(controller.vehicleAmounts.toString());
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Pickup Price'),
                      dense: true,

                      selectedTileColor: Colors.blueAccent,
                      activeColor: getColorFromHex(depColor),
                      // subtitle: Text(
                      //     controller
                      //             .customItineraryDatas
                      //             .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                      //                 ?[vehicleIndex]
                      //             .pickupPrice ??
                      //         '',
                      //     style: subheading2),
                      value: controller.isCheckedVehiclePickupPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] ??
                          false,
                      onChanged: (bool? value) {
                        if (value!) {
                          // Checkbox is checked
                          final String? price = controller
                              .customItineraryDatas
                              .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                                  ?[vehicleIndex]
                              .addonPrice;
                          final int pric = int.parse(price!.trim());
                          final int tot = pric * qty!;

                          controller.vehiclePrices.add(tot.toString());
                          controller.isCheckedVehiclePickupPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] = true;
                          controller.vehicleAmounts
                              .update('Day ${dayIndex + 1}',
                                  (Map<String, String> data) {
                            return <String, String>{
                              ...data,
                              'Pickup Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}':
                                  controller
                                          .customItineraryDatas
                                          .vehiclesForSingleDay?[
                                              'Day ${dayIndex + 1}']
                                              ?[vehicleIndex]
                                          .pickupPrice ??
                                      ''
                            };
                          }, ifAbsent: () {
                            return <String, String>{
                              'Pickup Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}':
                                  controller
                                          .customItineraryDatas
                                          .vehiclesForSingleDay?[
                                              'Day ${dayIndex + 1}']
                                              ?[vehicleIndex]
                                          .pickupPrice ??
                                      ''
                            };
                          });
                        } else {
                          // Checkbox is unchecked
                          final String? price = controller
                              .customItineraryDatas
                              .vehiclesForSingleDay?['Day ${dayIndex + 1}']
                                  ?[vehicleIndex]
                              .addonPrice;
                          final int pric = int.parse(price!.trim());
                          final int tot = pric * qty!;

                          controller.vehiclePrices.remove(tot.toString());
                          controller.isCheckedVehiclePickupPrice[
                              'Day ${dayIndex + 1}']?[vehicleIndex] = false;
                          controller.vehicleAmounts['Day ${dayIndex + 1}']?.remove(
                              'Pickup Price for ${controller.customItineraryDatas.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName}');
                        }
                        controller.update(<int>[vehicleIndex]);
                        log(controller.vehicleAmounts.toString());
                      },
                    ),
                  ],
                );
              });
        });
  }

  Future<void> checkAmount() {
    return Get.bottomSheet(
      elevation: 20,
      enterBottomSheetDuration: const Duration(milliseconds: 600),
      exitBottomSheetDuration: const Duration(milliseconds: 600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Material(
          animationDuration: const Duration(milliseconds: 750),
          borderRadius: BorderRadius.circular(10),
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'TOTAL AMOUNT OF PACKAGE IS\n ${controller.totalAmountOfPackage()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  const Text('Advance amount :'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text('2000',
                                style: subheading2.copyWith(fontSize: 30))),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add)),
                        Expanded(
                          child: CustomTextFormField(
                            initialValue: '0',
                            labelText: 'Advance amount',
                            onChanged: (String value) {
                              controller.extraAdvAmount.value =
                                  int.parse(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text('Total advance amount'),
                  Obx(() {
                    return Text(
                        '${controller.advAmount.value + controller.extraAdvAmount.value}',
                        style: subheading2.copyWith(fontSize: 30));
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Padding buildLabel(
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
                style: subheading1.copyWith(
                    overflow: TextOverflow.visible, color: color),
              ),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              child: Center(
                child: Text(
                  data,
                  style: subheading1.copyWith(
                      overflow: TextOverflow.visible, color: color),
                ),
              ),
            ),
          ],
        ),
        const Divider()
      ],
    ),
  );
}
