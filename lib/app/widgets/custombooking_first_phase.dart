import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../core/theme/style.dart';
import '../../core/utils/constants.dart';
import '../../main.dart';
import '../data/models/network_models/activity_model.dart';
import '../data/models/network_models/addons_model.dart';
import '../data/models/network_models/places_model.dart';
import '../modules/custom_booking/controllers/custom_booking_controller.dart';
import 'custom_button.dart';
import 'custom_date_picker.dart';
import 'custom_dropdown.dart';
import 'custom_text_form_field.dart';
import 'food_section.dart';
import 'rooms_section.dart';
import 'vehicle_section.dart';

Widget buildFirstPhase(CustomBookingController controller) {
  return GetBuilder<CustomBookingController>(builder: (_) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomDropDownButton(
            errorText: controller.notSelectedWithoutTransitTour.value,
            dropdownValues: controller.tourValues,
            onChanged: (String? selectedTour) async {
              controller.selectedTourWithoutTransit.value =
                  selectedTour.toString();
              controller.update();
              controller.roomCategoryModel.clear();
              controller.vehicleCategoryModel.clear();
              controller.selectedRoomCategories.clear();
              controller.selectedRoomCategory.value = '';

              controller.selectedRoomTypes.clear();
              controller.roomCategoryDropDown.clear();
              controller.selectedRoomModel.clear();
              controller.roomTypes.clear();
              controller.roomTypesDropDown.clear();
              controller.selectedVehicleTypes.clear();
              controller.vehicleTypesDropDown.clear();
              controller.selectedVehicleModel.clear();
              controller.selectedRoomTypes.clear();
              controller.selectedRoomes.clear();
              controller.roomTypes.clear();
              controller.foodModel.clear();
              controller.selectedFoods.clear();
              controller.selectedFoodsForDays.clear();
              await controller
                  .getRoomCategoriesFromApi()
                  .then((dynamic value) async {
                await controller
                    .getVehicleCategoriesFromApi()
                    .then((dynamic value) async {
                  await controller.getFoods();
                  controller.tourSelected.value = true;
                });
              });
            },
            labelText: 'Select Tour',
            value: controller.selectedTourWithoutTransit.value != null &&
                    controller.selectedTourWithoutTransit.value.isNotEmpty
                ? controller.selectedTourWithoutTransit.value
                : null,
          ),
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomDatePickerField(
            isTime: true,
            labelName: 'Tour pickup/arrival/starting time and date',
            hintText: 'Tour pickup/arrival/starting time and date',
            validator: (String? value) =>
                controller.validateSelectedTourStartingDateTime(value),
            onChange: (String value) {
              controller.tourStartingDateTime = value;
              log('ITINERARY tour starting datetime: ${controller.tourStartingDateTime}');

              controller.update();
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomDatePickerField(
            isTime: true,
            labelName: 'Tour dropoff/departure/ending time and date',
            hintText: 'Tour dropoff/departure/ending time and date',
            validator: (String? value) =>
                controller.validateSelectedTourEndingDateTime(value),
            onChange: (String value) {
              controller.tourEndingDateTime = value;
              log('ITINERARY tour ending Date time: ${controller.tourEndingDateTime}');

              controller.update();
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: CustomTextFormField(
                  textInPutAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  labelText: 'Days',
                  onChanged: (String p0) {
                    controller.vehicleTypesDropDown.clear();
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.isFetchingData['Day ${i + 1}'] = false;
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.foodsForSingleDayName['Day ${i + 1}'] = [];
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller
                              .activitiesQuantityForItinerary['Day ${i + 1}'] =
                          <Map<String, String>>[];
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.vehicleNameForItinerary['Day ${i + 1}'] =
                          <Map<String, String>>[];
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.vehicleQuantityForItinerary['Day ${i + 1}'] =
                          <Map<String, String>>[];
                    }
                    if (controller.itinerarySnapshots.isNotEmpty) {
                      controller.itinerarySnapshots.clear();
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.itinerarySnapshots['Day ${i + 1}'] =
                          <String, dynamic>{
                        'place_id': null,
                        'addons': null,
                        'activity': null,
                        'vehicle': null,
                        'room': null,
                        'food': null,
                      };
                    }
                    log('ÍTINERART SNAP ${controller.itinerarySnapshots}');
                    log('ITINERARY days: ${controller.days.value}');
                    controller.days.value = int.parse(p0);
                    for (int i = 1; i <= int.parse(p0); i++) {
                      controller.foodsForItinerary['Day $i'] =
                          <Map<String, String>>[];
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.placesForItinerary['Day ${i + 1}'] =
                          PlacesModel();
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.selectedActivityForaday['Day ${i + 1}'] =
                          <ActivityModel>[];
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.vehiclesForItinerary['Day ${i + 1}'] =
                          <String>[];
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.addonsForItinerary['Day ${i + 1}'] =
                          <AddonsModel>[];
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.activitiesForItinerary['Day ${i + 1}'] =
                          <ActivityModel>[];
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.activitiespaxForItinerary['Day ${i + 1}'] =
                          <String>[];
                    }

                    log(controller.days.value.toString());
                    controller.update();
                  },
                  validator: (String? p0) => controller.validateDaysofTour(p0),
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  textInPutAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  labelText: 'Nights',
                  onChanged: (String p0) {
                    controller.nights.value = int.parse(p0);

                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.roomNameForItinerary['Night ${i + 1}'] =
                          <Map<String, String>>[];
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.roomQuantityForItinerary['Night ${i + 1}'] =
                          <Map<String, String>>[];
                    }

                    controller.selectedRoomTypes.clear();
                    controller.selectedRoomes.clear();
                    controller.roomPrice.clear();
                    log('ITINERARY nights: ${controller.nights.value}');

                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.roomPrice['Night ${i + 1}'] = <String, int>{};
                    }
                    for (int i = 0; i < int.parse(p0); i++) {
                      controller.roomsForItinerary['Night ${i + 1}'] =
                          <String>[];
                    }

                    controller.update();
                  },
                  validator: (String? p0) =>
                      controller.validateNightsofTour(p0),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: CustomTextFormField(
                  textInPutAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  labelText: 'Adults',
                  onChanged: (String p0) {
                    controller.adults.value = int.parse(p0);
                    log('ITINERARY adults: ${controller.adults.value}');

                    controller.update();
                  },
                  validator: (String? p0) => controller.validateAdultsCount(p0),
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  textInPutAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  labelText: 'Kids',
                  onChanged: (String p0) {
                    controller.kids.value = int.parse(p0);
                    log('ITINERARY kids: ${controller.kids.value}');

                    controller.update();
                  },
                  validator: (String? p0) => controller.validateKidsCount(p0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: CustomTextFormField(
                  initialValue: '0',
                  textInPutAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  labelText: 'Infants',
                  onChanged: (String p0) {
                    controller.infants.value = int.parse(p0);
                    log('ITINERARY infants: ${controller.infants.value}');

                    controller.update();
                  },
                  validator: (String? p0) =>
                      controller.validateInfantsCount(p0),
                ),
              ),
              const Expanded(
                flex: 5,
                child: SizedBox(
                  height: 50,
                  width: 60,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        Obx(() => controller.searchingRooms.value
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Searching Rooms . . . ', style: heading3),
                  ),
                ],
              )
            : controller.nights.value == 0
                ? Text('Add nights', style: subheading2)
                : Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Rooms', style: heading3),
                      ),
                    ],
                  )),
        Obx(() => controller.roomCategoryDropDown != null &&
                controller.roomCategoryDropDown.isNotEmpty &&
                controller.tourSelected.value &&
                controller.nights.value != 0
            ? RoomSection(controller: controller)
            : controller.roomCategoryDropDown != null &&
                    controller.roomCategoryDropDown.isEmpty &&
                    controller.tourSelected.value
                ? Text(
                    'No rooms found in ${controller.selectedTourWithoutTransit.value}',
                    style: subheading2)
                : const SizedBox()),
        Obx(() => controller.searchingVehicles.value
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Searching vehicles . . . ', style: heading3),
                  ),
                ],
              )
            : controller.days.value == 0
                ? Text('Add days', style: subheading2)
                : Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Vehicles', style: heading3),
                      ),
                    ],
                  )),
        Obx(() => controller.vehicleCtegoryDropDown != null &&
                controller.vehicleCtegoryDropDown.isNotEmpty &&
                controller.tourSelected.value &&
                controller.days.value != 0
            ? VehicleSection(controller: controller)
            : controller.vehicleCtegoryDropDown != null &&
                    controller.vehicleCtegoryDropDown.isEmpty
                ? Text(
                    'No Vehicles found in ${controller.selectedTourWithoutTransit.value}',
                    style: subheading2)
                : const SizedBox()),
        Obx(() => controller.tourSelected.value != true
            ? const SizedBox()
            : controller.searchingFood.value
                ? Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Searching Foods . . . ', style: heading3),
                      ),
                    ],
                  )
                : controller.foodModel != null && controller.foodModel.isEmpty
                    ? SizedBox()
                    : Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Food', style: heading3),
                          ),
                        ],
                      )),
        Obx(() => controller.foodModel != null &&
                controller.foodModel.isNotEmpty &&
                controller.tourSelected.value
            ? controller.days.value == 0
                ? const Text('Add Days')
                : controller.nights.value == 0
                    ? const Text('Add Nights')
                    : FoodSection(controller: controller)
            : const SizedBox()),

        // Obx(
        //   () => controller.tourSelected.value &&
        //           controller.tourSelecting.value != true &&
        //           controller.foodModel.isNotEmpty
        //       ? Row(
        //           children: <Widget>[
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Text('Foods', style: heading3),
        //             ),
        //           ],
        //         )
        //       : const SizedBox(),
        // ),
        // Obx(
        //   () => controller.tourSelected.value &&
        //           controller.tourSelecting.value != true &&
        //           controller.foodModel.isNotEmpty
        //       ? FoodSection(controller: controller)
        //       : const SizedBox(),
        // ),

        const SizedBox(height: 5),
        Obx(
          () => CustomButton().showBlueButton(
              onTap: () => controller.onClickCreateItinerary(),
              isLoading: controller.onClickGenerateItinerary.value,
              label: 'Create Itinerary',
              color: getColorFromHex(depColor)!),
        )
      ],
    );
  });
}
