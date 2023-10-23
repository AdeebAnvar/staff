import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../core/theme/style.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/string_utils.dart';
import '../data/models/network_models/activity_model.dart';
import '../data/models/network_models/addons_model.dart';
import '../data/models/network_models/places_model.dart';
import '../data/models/network_models/single_room_model.dart';
import '../data/models/network_models/single_vehicle_model.dart';
import '../modules/custom_booking/controllers/custom_booking_controller.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';

class CreateItinerarySection extends StatelessWidget {
  const CreateItinerarySection({super.key, required this.controller});
  final CustomBookingController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              completedFirstPhase(controller),
              Text('Create Itinerary', style: heading2),
              const SizedBox(height: 10),
              Text(controller.selectedTourWithoutTransit.value,
                  style: paragraph1),
              const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.days.value,
                itemBuilder:
                    (BuildContext context, int dayListviewBuilderIndex) {
                  return buildAddDays(dayListviewBuilderIndex, controller);
                },
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 30),
              CustomButton().showBlueButton(
                  onTap: () => controller.calculateCost(context: context),
                  isLoading: false,
                  label: 'Calculate the cost',
                  color: getColorFromHex(depColor)!),
              const SizedBox(height: 20),
              Obx(() => CustomButton().showBlueButton(
                  onTap: () => controller.createItineraryPDF(controller),
                  isLoading: controller.generatingPDF.value,
                  label: 'Generate Itinerary',
                  color: getColorFromHex(depColor)!))
            ],
          ),
        ),
      );
    });
  }

  AnimatedContainer completedFirstPhase(CustomBookingController controller) {
    return AnimatedContainer(
      curve: Curves.bounceInOut,
      duration: const Duration(milliseconds: 600),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildLabel(
                  label: 'Tour',
                  data: controller.selectedTourWithoutTransit.toString()),
              if (controller.selectedTourWithTransit.isNotEmpty)
                buildLabel(label: 'Transit Tours', data: ''),
              if (controller.selectedTourWithTransit.isNotEmpty)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.selectedTourWithTransit.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final List<String> days = controller
                          .selectedTransitDays.entries
                          .toList()
                          .map((MapEntry<int, String> e) => e.value)
                          .toList();
                      final List<String> tours = controller
                          .selectedTourWithTransit.entries
                          .toList()
                          .map((MapEntry<int, String> e) => e.value)
                          .toList();
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0),
                        ),
                        child: buildLabel(label: days[index], data: tours[index]
                            // data: controller.selectedTourWithTransit[index]
                            //     .toString()
                            ),
                      );
                    })
              else
                const SizedBox(),
              const SizedBox(height: 10),
              buildLabel(
                  label: 'Tour pickup/arrival/starting time and date',
                  data: controller.tourStartingDateTime
                      .toString()
                      .parseFrom24Hours()
                      .toDateTime()),
              buildLabel(
                  label: 'Tour dropoff/departure/ending time and date',
                  data: controller.tourEndingDateTime
                      .toString()
                      .parseFrom24Hours()
                      .toDateTime()),
              buildLabel(
                  label: 'Adults', data: controller.adults.value.toString()),
              buildLabel(label: 'Kids', data: controller.kids.value.toString()),
              buildLabel(
                  label: 'Infants', data: controller.infants.value.toString()),
              buildLabel(label: 'Day', data: controller.days.value.toString()),
              buildLabel(
                  label: 'Night', data: controller.nights.value.toString()),
              const SizedBox(height: 20),
              Obx(
                () => controller.selectedRoomModel.isEmpty
                    ? const SizedBox()
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.selectedRoomModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String roomBuilding = controller
                              .selectedRoomModel.values
                              .elementAt(index);
                          final SingleRoomModel room = controller.roomModel
                              .firstWhere((SingleRoomModel sm) =>
                                  sm.roomBuilding == roomBuilding);
                          return Card(
                            elevation: 4,
                            color: getColorFromHex(depColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: <Widget>[
                                buildLabel(
                                    color: Colors.white,
                                    label: 'Room number',
                                    data: room.roomNumber.toString()),
                                buildLabel(
                                    label: 'Room category',
                                    color: Colors.white,
                                    data: room.roomCategory.toString()),
                                buildLabel(
                                    label: 'Room address',
                                    color: Colors.white,
                                    data: room.roomBuilding.toString()),
                                buildLabel(
                                    color: Colors.white,
                                    label: 'Room type',
                                    data: room.roomType.toString()),
                                // buildLabel(
                                //     color: Colors.white,
                                //     label: 'Room qty',
                                //     data:
                                //         '${controller.itineraryRoomsMoDEL.qty![index]}'),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 30),
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 20),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.selectedVehicleModel.length,
                itemBuilder: (BuildContext context, int index) {
                  final String vehId =
                      controller.selectedVehicleModel.values.elementAt(index);
                  final SingleVehicleModel veh = controller.vehicleModel
                      .firstWhere(
                          (SingleVehicleModel veh) => veh.vehicleId == vehId);

                  return Card(
                    color: getColorFromHex(depColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Column(
                      children: <Widget>[
                        buildLabel(
                            color: Colors.white,
                            label: 'Vehicle name',
                            data: veh.vehicleName.toString()),
                        buildLabel(
                            color: Colors.white,
                            label: 'vehicle category',
                            data: veh.categoryName.toString()),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddDays(
      int dayListviewBuilderIndex, CustomBookingController controller) {
    final List<String> transitDays = controller.selectedTransitDays.entries
        .toList()
        .map((MapEntry<int, String> e) => e.value)
        .toList();

    final bool isTransit =
        transitDays.contains('Day ${dayListviewBuilderIndex + 1}');
    return GetBuilder<CustomBookingController>(
      id: dayListviewBuilderIndex,
      init: CustomBookingController(),
      builder: (_) {
        return Card(
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ActionChip(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white10,
                onPressed: () {},
                label: isTransit != true
                    ? Text(
                        'Day ${dayListviewBuilderIndex + 1}',
                        style: subheading1.copyWith(
                            color: getColorFromHex(depColor)),
                      )
                    : Text(
                        style: subheading1.copyWith(
                            color: getColorFromHex(depColor)),
                        'Day ${dayListviewBuilderIndex + 1} - ${controller.selectedTourWithTransit[dayListviewBuilderIndex]}'),
              ),
              const SizedBox(height: 30),

              /// PLACES

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                child: MultiSelectDialogField<PlacesModel>(
                  listType: MultiSelectListType.CHIP,
                  chipDisplay: MultiSelectChipDisplay<PlacesModel>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  buttonIcon: const Icon(Icons.arrow_downward,
                      color: Colors.transparent),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  itemsTextStyle: paragraph2,
                  searchable: true,
                  selectedColor: getColorFromHex(depColor),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  selectedItemsTextStyle:
                      paragraph2.copyWith(color: Colors.white),
                  validator: (List<PlacesModel>? value) {
                    if (value!.length > 1) {
                      return 'Select only one place';
                    } else {
                      return '';
                    }
                  },
                  items: controller.placesModel
                      .map((PlacesModel e) =>
                          MultiSelectItem<PlacesModel>(e, e.placeName!))
                      .toList(),
                  title: const Text('Select Places'),
                  buttonText: Text(
                    'Select places',
                    style: subheading2.copyWith(
                      color: getColorFromHex(depColor),
                    ),
                  ),
                  onConfirm: (List<PlacesModel> p0) async {
                    log('hbknm,. ${p0[0].placeName}');
                    controller.isFetchingData[
                        'Day ${dayListviewBuilderIndex + 1}'] = true;

                    controller.itinerarySnapshots[
                        'Day ${dayListviewBuilderIndex + 1}']!['place_id'] = [
                      p0[0].placeId
                    ];
                    log('ghnjm, ${controller.itinerarySnapshots['Day ${dayListviewBuilderIndex + 1}']!['place_id']}');
                    if (p0.length == 1) {
                      for (int i = 0; i < controller.placesModel.length; i++) {
                        for (final PlacesModel place in p0) {
                          if (place == controller.placesModel[i]) {
                            controller.placeId = place.placeId!;
                          }
                        }
                      }
                      if (controller.addonsModel[
                                  'Day ${dayListviewBuilderIndex + 1}'] !=
                              null &&
                          controller
                              .addonsModel[
                                  'Day ${dayListviewBuilderIndex + 1}']!
                              .isNotEmpty) {
                        controller
                            .addonsModel['Day ${dayListviewBuilderIndex + 1}']!
                            .clear();
                        log('gvjbhnkml, ${controller.addonsModel}');
                      }
                      if (controller.activityModel[
                                  'Day ${dayListviewBuilderIndex + 1}'] !=
                              null &&
                          controller
                              .activityModel[
                                  'Day ${dayListviewBuilderIndex + 1}']!
                              .isNotEmpty) {
                        controller.activityModel[
                                'Day ${dayListviewBuilderIndex + 1}']!
                            .clear();
                      }
                      if (controller.selectedActivityForaday[
                                  'Day ${dayListviewBuilderIndex + 1}'] !=
                              null &&
                          controller
                              .selectedActivityForaday[
                                  'Day ${dayListviewBuilderIndex + 1}']!
                              .isNotEmpty) {
                        controller.selectedActivityForaday[
                                'Day ${dayListviewBuilderIndex + 1}']!
                            .clear();
                      }
                      if (controller.activitiesForSingleDayName[
                                  'Day ${dayListviewBuilderIndex + 1}'] !=
                              null &&
                          controller
                              .activitiesForSingleDayName[
                                  'Day ${dayListviewBuilderIndex + 1}']!
                              .isNotEmpty) {
                        controller.activitiesForSingleDayName[
                                'Day ${dayListviewBuilderIndex + 1}']!
                            .clear();
                      }
                      List<String> vehicleNames = <String>[];
                      List<int> vehicleQty = <int>[];
                      vehicleNames = controller
                          .vehicleQuantity[
                              'Day ${dayListviewBuilderIndex + 1}']!
                          .keys
                          .toList();
                      vehicleQty = controller
                          .vehicleQuantity[
                              'Day ${dayListviewBuilderIndex + 1}']!
                          .values
                          .toList();

                      controller.placesForSingleDay[
                          'Day ${dayListviewBuilderIndex + 1}'] = p0[0];
                      await controller.getVehiclePricesinPlaces(
                          controller.placeId,
                          vehicleNames,
                          vehicleQty,
                          dayListviewBuilderIndex);
                      controller.dummyvalue[
                          'Day ${dayListviewBuilderIndex + 1}'] = p0;
                      final List<String> placesNames = <String>[];
                      for (final PlacesModel ro in p0) {
                        placesNames.add(ro.placeName.toString());
                      }
                      controller.placesForSingleDayName[
                          'Day ${dayListviewBuilderIndex + 1}'] = placesNames;
                      controller.placesForItinerary[
                          'Day ${dayListviewBuilderIndex + 1}'] = p0[0];
                      await controller.getActivities(
                          controller.placeId,
                          'Day ${dayListviewBuilderIndex + 1}',
                          dayListviewBuilderIndex);
                      await controller.getAddons(
                          controller.placeId,
                          'Day ${dayListviewBuilderIndex + 1}',
                          dayListviewBuilderIndex);
                      controller.isFetchingData[
                          'Day ${dayListviewBuilderIndex + 1}'] = false;
                      controller.update(<int>[dayListviewBuilderIndex]);
                    }
                  },
                ),
              ),
              const SizedBox(height: 15),

              Obx(() {
                if (controller
                    .isFetchingData['Day ${dayListviewBuilderIndex + 1}']!) {
                  return const Center(
                      child: Row(
                    children: <Widget>[
                      Text('Please Wait . . . '),
                      CircularProgressIndicator(),
                    ],
                  ));
                } else {
                  return const SizedBox();
                }
              }),

              /// ADDONS

              if (controller
                          .addonsModel['Day ${dayListviewBuilderIndex + 1}'] !=
                      null &&
                  controller.addonsModel['Day ${dayListviewBuilderIndex + 1}']!
                      .isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 10.0),
                  child: MultiSelectDialogField<AddonsModel>(
                    listType: MultiSelectListType.CHIP,
                    buttonIcon: const Icon(Icons.arrow_downward,
                        color: Colors.transparent),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    itemsTextStyle: paragraph2,
                    searchable: true,
                    selectedColor: getColorFromHex(depColor),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    selectedItemsTextStyle:
                        paragraph2.copyWith(color: Colors.white),
                    chipDisplay: MultiSelectChipDisplay<AddonsModel>(
                      onTap: (AddonsModel p0) {
                        log('hjbnkm $p0');
                      },
                    ),
                    items: controller
                        .addonsModel['Day ${dayListviewBuilderIndex + 1}']!
                        .map((AddonsModel e) =>
                            MultiSelectItem<AddonsModel>(e, e.addonName!))
                        .toList(),
                    title: const Text('Select addons'),
                    buttonText: Text(
                      'Select addons',
                      style: subheading2.copyWith(
                        color: getColorFromHex(depColor),
                      ),
                    ),
                    onConfirm: (List<AddonsModel> p0) async {
                      final List<String> addonids = <String>[];
                      for (final AddonsModel addon in p0) {
                        final AddonsModel matchingAddon = controller
                            .addonsModel['Day ${dayListviewBuilderIndex + 1}']!
                            .firstWhere(
                                (AddonsModel element) => element == addon,
                                orElse: () => AddonsModel());

                        if (matchingAddon != null) {
                          addonids.add(matchingAddon.addonId.toString());
                        }
                      }
                      controller.itinerarySnapshots[
                              'Day ${dayListviewBuilderIndex + 1}']!['addons'] =
                          addonids;
                      log('jkm,l ${controller.itinerarySnapshots['Day ${dayListviewBuilderIndex + 1}']}');

                      List<String> vehicleNames = <String>[];
                      List<int> vehicleQty = <int>[];
                      vehicleNames = controller
                          .vehicleQuantity[
                              'Day ${dayListviewBuilderIndex + 1}']!
                          .keys
                          .toList();
                      log('uunuu $vehicleNames');
                      vehicleQty = controller
                          .vehicleQuantity[
                              'Day ${dayListviewBuilderIndex + 1}']!
                          .values
                          .toList();

                      await controller.getVehiclePricesinAddons(addonids,
                          vehicleNames, vehicleQty, dayListviewBuilderIndex);

                      controller.selectedAddonsForaday[
                          'Day ${dayListviewBuilderIndex + 1}'] = p0;
                      final List<String> addonNames = <String>[];
                      for (final AddonsModel ro in p0) {
                        addonNames.add(ro.addonName.toString());
                      }
                      controller.addonsForSingleDayName[
                          'Day ${dayListviewBuilderIndex + 1}'] = addonNames;
                      controller.addonsForItinerary[
                          'Day ${dayListviewBuilderIndex + 1}'] = p0;
                      log('gbhjnkm ${controller.addonsForItinerary['Day ${dayListviewBuilderIndex + 1}']!.map((AddonsModel e) => e.addonDes).join(' and ')}');
                      log('gbhjnkm ${controller.addonsForItinerary}');
                    },
                  ),
                ),

              // ACTIVITES

              if (controller.activityModel[
                          'Day ${dayListviewBuilderIndex + 1}'] !=
                      null &&
                  controller
                      .activityModel['Day ${dayListviewBuilderIndex + 1}']!
                      .isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 10.0),
                  child: MultiSelectDialogField<ActivityModel>(
                    listType: MultiSelectListType.CHIP,
                    buttonIcon: const Icon(Icons.arrow_downward,
                        color: Colors.transparent),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    itemsTextStyle: paragraph2,
                    searchable: true,
                    selectedColor: getColorFromHex(depColor),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    selectedItemsTextStyle:
                        paragraph2.copyWith(color: Colors.white),
                    chipDisplay: MultiSelectChipDisplay<ActivityModel>(
                      onTap: (ActivityModel p0) {
                        log(p0.toString());
                      },
                    ),
                    items: controller
                        .activityModel['Day ${dayListviewBuilderIndex + 1}']!
                        .map((ActivityModel e) =>
                            MultiSelectItem<ActivityModel>(e, e.activityName!))
                        .toList(),
                    title: Text(
                      'Select activity',
                      style: subheading2.copyWith(
                          color: getColorFromHex(depColor)),
                    ),
                    buttonText: Text(
                      'Select activity',
                      style: subheading2.copyWith(
                          color: getColorFromHex(depColor)),
                    ),
                    onConfirm: (List<ActivityModel> p0) {
                      final List<String> activityIds = <String>[];

                      log('hiiihihi $activityIds');
                      for (final ActivityModel element in p0) {
                        activityIds.add(element.activityId!);
                      }
                      final List<Map<String, dynamic>> activityList =
                          activityIds.map((String activityId) {
                        return <String, String?>{
                          'activity_id': activityId,
                          'activity_qty': null,
                        };
                      }).toList();

                      controller.itinerarySnapshots[
                              'Day ${dayListviewBuilderIndex + 1}']![
                          'activity'] = activityList;

                      controller.selectedActivityForaday[
                          'Day ${dayListviewBuilderIndex + 1}'] = p0;
                      log('gvbhnj ${controller.selectedActivityForaday}');
                      for (final ActivityModel acti in p0) {
                        final ActivityModel activi = controller.activityModel[
                                'Day ${dayListviewBuilderIndex + 1}']!
                            .firstWhere(
                          (ActivityModel element) => element == acti,
                          orElse: () => ActivityModel(),
                        );
                        for (int i = 0; i < controller.days.value; i++) {
                          controller
                                  .activitiesForSingleDayName['Day ${i + 1}'] =
                              <String>[];
                        }
                        controller.activitiesForSingleDayName[
                                'Day ${dayListviewBuilderIndex + 1}']!
                            .add(activi.activityName.toString());
                      }
                      log('vfrvr $p0');
                      final List<String> activityNames = <String>[];
                      log('bnkm,jl ${controller.activitiespaxForItinerary}');
                      for (final ActivityModel ro in p0) {
                        activityNames.add(ro.activityName.toString());
                        controller.activitiespaxForItinerary[
                                'Day ${dayListviewBuilderIndex + 1}']!
                            .add(ro.activityName.toString());
                      }

                      for (var i = 0; i < p0.length; i++) {
                        controller.activitiesQuantityForItinerary[
                                'Day ${dayListviewBuilderIndex + 1}']!
                            .add({'qty': ''});
                      }
                      controller.activitiesForItinerary[
                          'Day ${dayListviewBuilderIndex + 1}'] = p0;
                      log('bnkm,l ${controller.activitiesForItinerary}');
                    },
                  ),
                ),
              Obx(() => controller.selectedActivityForaday[
                              'Day ${dayListviewBuilderIndex + 1}'] !=
                          null &&
                      controller
                          .selectedActivityForaday[
                              'Day ${dayListviewBuilderIndex + 1}']!
                          .isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller
                          .selectedActivityForaday[
                              'Day ${dayListviewBuilderIndex + 1}']
                          ?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ActionChip(
                                      onPressed: () {},
                                      label: Text(
                                        controller
                                                .selectedActivityForaday[
                                                    'Day ${dayListviewBuilderIndex + 1}']
                                                    ?[index]
                                                .activityName ??
                                            '',
                                        style: subheading3,
                                      ),
                                    ),
                                  ),
                                  const Text('x'),
                                  Expanded(
                                    child: CustomTextFormField(
                                      labelText: 'Pax',
                                      onChanged: (String value) {
                                        controller.activitiesQuantityForItinerary[
                                                'Day ${dayListviewBuilderIndex + 1}']![
                                            index]['qty'] = value;
                                        final List<
                                            Map<String,
                                                dynamic>> activityList = controller
                                                        .itinerarySnapshots[
                                                    'Day ${dayListviewBuilderIndex + 1}']![
                                                'activity']
                                            as List<Map<String, dynamic>>;
                                        for (final Map<String,
                                                dynamic> activityData
                                            in activityList) {
                                          if (activityData['activity_id'] ==
                                              controller
                                                  .selectedActivityForaday[
                                                      'Day ${dayListviewBuilderIndex + 1}']
                                                      ?[index]
                                                  .activityId) {
                                            activityData['activity_qty'] =
                                                value;
                                            break;
                                          }
                                        }
                                        final String dayKey =
                                            'Day ${dayListviewBuilderIndex + 1}';
                                        final num? activityPrice = controller
                                            .selectedActivityForaday[dayKey]
                                                ?[index]
                                            .activityPrice;

                                        if (activityPrice != null) {
                                          final Map<num?, String>
                                              activityAmountForDay = controller
                                                      .activityAmount[dayKey] ??
                                                  <num?, String>{};

                                          activityAmountForDay[activityPrice] =
                                              value;

                                          controller.activityAmount[dayKey] =
                                              activityAmountForDay;
                                          log(controller.activityAmount
                                              .toString());
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const SizedBox()),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}

Padding buildLabel(
    {required String label, required String data, Color color = Colors.black}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.justify,
            style: subheading3.copyWith(
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w500,
                color: color),
          ),
        ),
        const Expanded(child: SizedBox()),
        Expanded(
          child: Center(
            child: Text(
              data,
              style: subheading3.copyWith(
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.w500,
                  color: color),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget buildAddDays(
//     int dayListviewBuilderIndex, CustomBookingController controller) {
//   final List<String> transitDays = controller.selectedTransitDays.entries
//       .toList()
//       .map((MapEntry<int, String> e) => e.value)
//       .toList();

//   final bool isTransit =
//       transitDays.contains('Day ${dayListviewBuilderIndex + 1}');
//   return GetBuilder<CustomBookingController>(
//     id: dayListviewBuilderIndex,
//     init: CustomBookingController(),
//     builder: (_) {
//       return Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             ActionChip(
//               elevation: 10,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               backgroundColor: getColorFromHex(depColor),
//               onPressed: () {},
//               label: isTransit != true
//                   ? Text(
//                       'Day ${dayListviewBuilderIndex + 1}',
//                       style: subheading1.copyWith(color: Colors.white),
//                     )
//                   : Text(
//                       style: subheading1.copyWith(color: Colors.white),
//                       'Day ${dayListviewBuilderIndex + 1} - ${controller.selectedTourWithTransit[dayListviewBuilderIndex]}'),
//             ),
//             const SizedBox(height: 30),
//             GetBuilder<CustomBookingController>(
//                 id: dayListviewBuilderIndex,
//                 builder: (_) {
//                   return CustomDropDownButton(
//                       dropdownValues: controller.placeValues,
//                       value: controller.selectedPlacesModel[
//                           'Day ${dayListviewBuilderIndex + 1}'],
//                       onChanged: (String? value) async {
//                         controller.selectedPlacesModel[
//                                 'Day ${dayListviewBuilderIndex + 1}'] =
//                             value.toString();
//                         final String tourId = controller.tours
//                             .firstWhere((TourModel e) =>
//                                 e.tourName ==
//                                 controller.selectedTourWithoutTransit.value)
//                             .tourId!;
//                         if (controller.toursIds != null &&
//                             controller.toursIds.isNotEmpty) {
//                           await controller.getPlaces(
//                               controller.toursIds[dayListviewBuilderIndex + 1]);
//                         } else {
//                           await controller.getPlaces(tourId);
//                         }
//                         if (controller.placesModel.isNotEmpty) {
//                           final String placeId = controller.placesModel
//                               .firstWhere((PlacesModel element) =>
//                                   element.placeName ==
//                                   controller
//                                       .placeValues[dayListviewBuilderIndex])
//                               .placeId!;
//                           await controller.getAddons(placeId);
//                           await controller.getActivities(placeId);
//                         } else {}

//                         controller.toursIds != null &&
//                                 controller.toursIds.isNotEmpty
//                             ? await controller.getFoods(
//                                 controller
//                                     .toursIds[dayListviewBuilderIndex + 1],
//                                 dayListviewBuilderIndex)
//                             : await controller.getFoods(
//                                 tourId, dayListviewBuilderIndex);
//                         controller.update(<int>[dayListviewBuilderIndex]);
//                         log('hrtgb ${controller.selectedPlacesModel}');
//                       },
//                       labelText: 'Select Place',
//                       errorText: '');
//                 }),
//             GetBuilder<CustomBookingController>(
//                 id: dayListviewBuilderIndex,
//                 builder: (_) {
//                   return CustomDropDownButton(
//                       dropdownValues: controller.selectedVehicleForDropDown,
//                       value: controller.selectedVehicleOfDropdown[
//                           'Day ${dayListviewBuilderIndex + 1}'],
//                       onChanged: (String? value) async {
//                         controller.selectedVehicleOfDropdown[
//                                 'Day ${dayListviewBuilderIndex + 1}'] =
//                             value.toString();
//                         controller.update(<int>[dayListviewBuilderIndex]);
//                       },
//                       labelText: 'Select vehicle',
//                       errorText: '');
//                 }),
//             GetBuilder<CustomBookingController>(
//                 id: dayListviewBuilderIndex,
//                 builder: (_) {
//                   return CustomDropDownButton(
//                       dropdownValues: controller.selectedRoomsForDropDown,
//                       value: controller.selectedVehicleOfDropdown[
//                           'Day ${dayListviewBuilderIndex + 1}'],
//                       onChanged: (String? value) async {
//                         controller.selectedVehicleOfDropdown[
//                                 'Day ${dayListviewBuilderIndex + 1}'] =
//                             value.toString();
//                         controller.update(<int>[dayListviewBuilderIndex]);
//                       },
//                       labelText: 'Select room',
//                       errorText: '');
//                 }),
//             if (controller.activityModel.isNotEmpty)
//               GetBuilder<CustomBookingController>(
//                   id: dayListviewBuilderIndex,
//                   builder: (_) {
//                     return CustomDropDownButton(
//                         dropdownValues: controller.activityValues,
//                         value: controller.selectedactivityModel[
//                             'Day ${dayListviewBuilderIndex + 1}'],
//                         onChanged: (String? value) {
//                           controller.selectedactivityModel[
//                                   'Day ${dayListviewBuilderIndex + 1}'] =
//                               value.toString();
//                           controller.update(<int>[dayListviewBuilderIndex]);
//                         },
//                         labelText: 'Select Activity',
//                         errorText: '');
//                   }),
//             if (controller.addonsModel.isNotEmpty &&
//                 controller.addonsModel.length > dayListviewBuilderIndex)
//               GetBuilder<CustomBookingController>(
//                   id: dayListviewBuilderIndex,
//                   builder: (_) {
//                     return CustomDropDownButton(
//                         dropdownValues: controller.addonValues,
//                         value: controller.selectedaddonModel[
//                             'Day ${dayListviewBuilderIndex + 1}'],
//                         onChanged: (String? value) {
//                           controller.selectedaddonModel[
//                                   'Day ${dayListviewBuilderIndex + 1}'] =
//                               value.toString();
//                           controller.update(<int>[dayListviewBuilderIndex]);
//                         },
//                         labelText: 'Select Addon',
//                         errorText: '');
//                   }),
//             if (controller.foodModel.isNotEmpty &&
//                 controller.foodModel.length > dayListviewBuilderIndex)
//               GetBuilder<CustomBookingController>(
//                   id: dayListviewBuilderIndex,
//                   builder: (_) {
//                     return CustomDropDownButton(
//                         dropdownValues: controller.foodTypeValues,
//                         value: controller.selectedFoodModel[
//                             'Day ${dayListviewBuilderIndex + 1}'],
//                         onChanged: (String? value) {
//                           controller.selectedFoodModel[
//                                   'Day ${dayListviewBuilderIndex + 1}'] =
//                               value.toString();
//                           controller.update(<int>[dayListviewBuilderIndex]);
//                         },
//                         labelText: 'Select Food',
//                         errorText: '');
//                   }),
//             const SizedBox(height: 15),
//             const SizedBox(height: 15),
//           ],
//         ),
//       );
//     },
//   );
// }
