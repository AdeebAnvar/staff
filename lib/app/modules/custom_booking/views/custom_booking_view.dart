import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../data/models/network_models/activity_model.dart';
import '../../../data/models/network_models/addons_model.dart';
import '../../../data/models/network_models/places_model.dart';
import '../../../widgets/create_itinerary_section.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_loading_screen.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/rooms_section.dart';
import '../../../widgets/vehicle_section.dart';
import '../controllers/custom_booking_controller.dart';

class CustomBookingView extends GetView<CustomBookingController> {
  const CustomBookingView({super.key});
  @override
  Widget build(BuildContext context) {
    final CustomBookingController controller =
        Get.put(CustomBookingController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: const Text('Custom Booking'),
      ),
      body: controller.obx(
        onLoading: const CustomLoadingScreen(),
        (CustomBookingView? state) => GetBuilder<CustomBookingController>(
          init: CustomBookingController(),
          builder: (_) => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const RangeMaintainingScrollPhysics(
              parent: BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: <Widget>[
                  Obx(
                    () => controller.firstPhaseCompleted.value
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child:
                                CreateItinerarySection(controller: controller),
                          )
                        : buildFirstPhase(controller),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
                controller.roomCategoryModel.clear();
                controller.vehicleCategoryModel.clear();
                controller.selectedRoomCategories.clear();
                controller.selectedRoomCategory.value = '';
                controller.selectedVehicleCategory.value = '';
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
                controller.tourSelecting.value = true;
                controller.roomTypes.clear();
                controller.roomTypesNotFound.value = '';
                await controller
                    .getRoomCategoriesFromApi()
                    .then((dynamic value) async {
                  await controller
                      .getVehicleCategoriesFromApi()
                      .then((dynamic value) async {
                    await controller.getFoods();
                    controller.tourSelecting.value = false;
                    controller.tourSelected.value = true;
                  });
                });
                controller.update();
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
                      log('ITINERARY days: ${controller.days.value}');
                      controller.days.value = int.parse(p0);
                      for (int i = 0; i < controller.days.value; i++) {
                        controller.isCheckedTransitDays[i] = false;
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
                    validator: (String? p0) =>
                        controller.validateDaysofTour(p0),
                  ),
                ),
                Expanded(
                  child: CustomTextFormField(
                    textInPutAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    labelText: 'Nights',
                    onChanged: (String p0) {
                      controller.nights.value = int.parse(p0);
                      controller.selectedRoomTypes.clear();
                      controller.selectedRoomes.clear();
                      controller.roomPrice.clear();
                      log('ITINERARY nights: ${controller.nights.value}');

                      for (int i = 0; i < int.parse(p0); i++) {
                        controller.roomPrice['Night ${i + 1}'] =
                            <String, int>{};
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
                    validator: (String? p0) =>
                        controller.validateAdultsCount(p0),
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
          // if (controller.isTransit.value == true)
          //   ActionChip(
          //     backgroundColor: getColorFromHex(depColor)!.withOpacity(0.3),
          //     onPressed: () => onClickSelectTransitDays(),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     label: Text('Select Transit Days', style: paragraph2),
          //   ),
          // if (controller.isCheckedTransitDays != null ||
          //     controller.isTransit.value != true)
          //   transitDays(controller),
          // Obx(
          //   () => controller.notAddedTransitDays.value
          //       ? Text(
          //           'Add transit days',
          //           style: subheading1.copyWith(color: Colors.redAccent),
          //         )
          //       : const Text(''),
          // ),
          // const SizedBox(height: 20),
          // CustomTabSection(controller: controller),
          // Obx(
          //   () {
          //     if (controller.isSelectedTab.value == 0) {
          //       return RoomSection(controller: controller);
          //     } else {
          //       return VehicleSection(controller: controller);
          //     }
          //   },
          // ),
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
              : const SizedBox()),
          // Obx(
          //   () => controller.tourSelected.value &&
          //           controller.tourSelecting.value != true &&
          //           controller.roomCategoryDropDown != null &&
          //           controller.roomCategoryDropDown.isNotEmpty
          //       ? RoomSection(controller: controller)
          //       : const SizedBox(),
          // ),
          // Obx(
          //   () => controller.tourSelected.value &&
          //           controller.tourSelecting.value != true
          //       ? Row(
          //           children: <Widget>[
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Text('Vehicles', style: heading3),
          //             ),
          //           ],
          //         )
          //       : const SizedBox(),
          // ),
          // Obx(
          //   () => controller.tourSelected.value &&
          //           controller.tourSelecting.value != true &&
          //           controller.vehicleCtegoryDropDown.isNotEmpty
          //       ? VehicleSection(controller: controller)
          //       : const SizedBox(),
          // ),

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

  CheckboxMenuButton priceCheckBox(
      {required bool? value,
      required void Function(bool?)? onChanged,
      required String label}) {
    return CheckboxMenuButton(
        value: value,
        style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 500),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        ),
        onChanged: onChanged,
        child: Text(label));
  }

  ListView transitDays(CustomBookingController controller) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.selectedTransitDays.length,
      itemBuilder: (BuildContext context, int index) {
        final List<String> days = controller.selectedTransitDays.entries
            .toList()
            .map((MapEntry<int, String> e) => e.value)
            .toList();
        return Row(
          children: <Widget>[
            Expanded(
              child: ActionChip(
                onPressed: () {},
                backgroundColor: getColorFromHex(depColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                label: Text(
                  days[index],
                  style: subheading1.copyWith(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Obx(() {
                return CustomDropDownButton(
                  dropdownValues: controller.tourValues,
                  onChanged: (String? newValue) {
                    if (newValue != null && newValue.isNotEmpty) {
                      controller.selectedTourWithTransit[
                          controller.dayIndexes[index]] = newValue;
                    } else {}
                    log(controller.selectedTourWithTransit.toString());
                  },
                  labelText: 'Select Tour',
                  value: controller.selectedTourWithTransit.isNotEmpty
                      ? controller
                          .selectedTourWithTransit[controller.dayIndexes[index]]
                      : null,
                  errorText: controller.notSelectedTour.value,
                );
              }),
            )
          ],
        );
      },
    );
  }

  Row transitRadioButtons(CustomBookingController controller) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Obx(
            () => RadioListTile<String>(
              title: const Text('In Transit'),
              value: 'In Transit',
              activeColor: getColorFromHex(depColor),
              groupValue: controller.selectedOption.value,
              onChanged: (String? value) {
                controller.selectedOption(value);
                controller.isTransit.value = true;
                controller.update();
              },
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => RadioListTile<String>(
              activeColor: getColorFromHex(depColor),
              title: const Text('No Transit'),
              value: 'No Transit',
              groupValue: controller.selectedOption.value,
              onChanged: (String? value) {
                controller.selectedOption(value);
                controller.isTransit.value = false;
                controller.notAddedTransitDays.value = false;
                controller.update();
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> onClickSelectTransitDays() {
    return Get.bottomSheet(
      barrierColor: Colors.transparent,
      elevation: 10,
      enterBottomSheetDuration: const Duration(milliseconds: 500),
      exitBottomSheetDuration: const Duration(milliseconds: 500),
      Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(children: <Widget>[
              const Text('SELECT DAYS'),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.days.value,
                itemBuilder: (BuildContext context, int index) => Obx(() {
                  return CheckboxListTile(
                    value: controller.isCheckedTransitDays[index],
                    onChanged: (bool? value) =>
                        controller.itemChangeOnTransitDay(index, value!),
                    dense: true,
                    activeColor: getColorFromHex(depColor),
                    secondary: Text('Day ${index + 1}'),
                  );
                }),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
