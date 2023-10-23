import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../core/theme/style.dart';
import '../data/models/network_models/room_category_model.dart';
import '../data/models/network_models/single_room_model.dart';
import '../modules/custom_booking/controllers/custom_booking_controller.dart';
import 'custom_dropdown.dart';
import 'custom_text_form_field.dart';

class RoomSection extends StatelessWidget {
  const RoomSection({super.key, required this.controller});
  final CustomBookingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 10),
      Text("*kids and infants can't caluclate for room",
          style: subheading2.copyWith(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
      Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Obx(
              () {
                return CustomDropDownButton(
                  dropdownValues: controller.roomCategoryDropDown,
                  value: controller.selectedRoomCategory.value != null &&
                          controller.selectedRoomCategory.value.isNotEmpty
                      ? controller.selectedRoomCategory.value
                      : null,
                  onChanged: (String? value) async {
                    controller.roomTypes.clear();
                    log('ITINERARY roomCategories: ${controller.selectedRoomCategory.value}');

                    controller.roomTypesDropDown.clear();
                    controller.selectedRoomTypes.clear();
                    controller.selectedRoomes.clear();
                    controller.selectedRoomCategory.value = value.toString();
                    await controller.getRoomTypes();
                  },
                  labelText: 'Select room category',
                  errorText: '',
                );
              },
            ),
          ),
          Obx(() => controller.searchingRoomTypes.value
              ? const LinearProgressIndicator()
              : const SizedBox()),
          Obx(() => controller.roomTypesDropDown.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 10),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MultiSelectDialogField<String>(
                      items: controller.roomTypesDropDown
                          .map((String e) => MultiSelectItem<String>(
                              '${controller.selectedRoomCategory.value} $e',
                              '${controller.selectedRoomCategory.value} $e'))
                          .toList(),
                      searchable: true,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      listType: MultiSelectListType.CHIP,
                      onSaved: (List<String>? value) {},
                      onConfirm: (List<String> values) async {
                        controller.selectedRoomTypeNamesToDropDown.clear();
                        log(values.toString());
                        controller.roomModel.clear();
                        controller.selectedRoomTypes.clear();
                        controller.selectedRoomTypes.value = values;
                        controller.selectedRoomes.clear();
                        log('ITINERARY roomTypes: ${controller.selectedRoomTypes}');
                        List<String> roomShares = <String>[];
                        final List<String> roomCategoryIds = <String>[];
                        roomShares = values.map((String item) {
                          for (final String element in values) {
                            if (item.contains(element)) {
                              return item.replaceAll(
                                  controller.selectedRoomCategory.value, '');
                            }
                          }
                          return item; // Keep other items unchanged
                        }).toList();

                        for (final RoomCategoryModel element
                            in controller.roomCategoryModel) {
                          if (element.catName ==
                              controller.selectedRoomCategory.value) {
                            roomCategoryIds.add(element.catId.toString());
                          }
                        }
                        await controller.getRooms(
                            roomShares
                                .map((String item) => item.trim())
                                .toList(),
                            roomCategoryIds);

                        log('higiio $roomCategoryIds');
                        for (int i = 0; i < controller.nights.value; i++) {
                          controller.selectedRoomes['Night ${i + 1}'] =
                              <SingleRoomModel>[];
                        }
                      },
                      buttonIcon: const Icon(Icons.arrow_drop_down),
                      buttonText: const Text('Select RoomTypes'),
                    ),
                  ),
                )
              : const SizedBox()),
          Obx(
            () => controller.isGettingRooms.value
                ? const LinearProgressIndicator()
                : const SizedBox(),
          ),
          Obx(() => controller.roomModel.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 10),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MultiSelectDialogField<SingleRoomModel>(
                      items: controller.roomModel
                          .map((SingleRoomModel e) => MultiSelectItem<
                                  SingleRoomModel>(e,
                              '${e.roomBuilding} ${e.categoryName} ${e.roomType}'))
                          .toList(),
                      searchable: true,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (List<SingleRoomModel> values) async {
                        controller.selectedRoomTypeNamesToDropDown.clear();

                        // for (int i = 0; i < values.length; i++) {
                        //   controller.selectedRoomTypePrices['Night ${i + 1}'] =
                        //       <int>[];
                        // }

                        for (final SingleRoomModel element
                            in controller.roomModel) {
                          if (values.contains(element)) {
                            controller.selectedRoomTypeNamesToDropDown
                                .add(element);
                          }
                        }
                      },
                      buttonIcon: const Icon(Icons.arrow_drop_down),
                      buttonText: const Text('Select room'),
                    ),
                  ),
                )
              : const SizedBox()),
          Obx(() => controller.selectedRoomTypeNamesToDropDown.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: controller.nights.value,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int nightIndex) {
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
                                  label: Text('Night ${nightIndex + 1}'),
                                  onPressed: () {},
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 2,
                                      child: MultiSelectDialogField<
                                          SingleRoomModel>(
                                        buttonIcon:
                                            const Icon(Icons.arrow_drop_down),
                                        buttonText: const Text('Select Room'),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        listType: MultiSelectListType.CHIP,
                                        searchable: true,
                                        separateSelectedItems: true,
                                        items: controller
                                            .selectedRoomTypeNamesToDropDown
                                            .map((SingleRoomModel e) =>
                                                MultiSelectItem<
                                                        SingleRoomModel>(e,
                                                    '${e.roomBuilding} ${e.categoryName} ${e.roomType}'))
                                            .toList(),
                                        onConfirm:
                                            (List<SingleRoomModel> values) {
                                          final List<String> roomIds =
                                              <String>[];
                                          log('dcfvde ${controller.roomQuantityForItinerary}');

                                          for (final SingleRoomModel element
                                              in values) {
                                            roomIds.add(element.roomId!);
                                          }

                                          for (int j = 0;
                                              j < values.length;
                                              j++) {
                                            controller.roomQuantityForItinerary[
                                                    'Night ${nightIndex + 1}']!
                                                .add(
                                              <String, String>{'qty': ''},
                                            );
                                          }
                                          for (int j = 0;
                                              j < values.length;
                                              j++) {
                                            controller.roomNameForItinerary[
                                                    'Night ${nightIndex + 1}']!
                                                .add(
                                              <String, String>{'room_name': ''},
                                            );
                                          }

                                          log('dcfv qty${controller.roomQuantityForItinerary}');
                                          log('dcfv name ${controller.roomNameForItinerary}');

                                          final List<Map<String, dynamic>>
                                              roomList =
                                              roomIds.map((String roomId) {
                                            return <String, String?>{
                                              'room_id': roomId,
                                              'room_qty': null,
                                            };
                                          }).toList();

                                          controller.itinerarySnapshots[
                                                  'Day ${nightIndex + 1}']![
                                              'room'] = roomList;
                                          log(controller.itinerarySnapshots
                                              .toString());

                                          controller.selectedRoomes[
                                                  'Night ${nightIndex + 1}']!
                                              .clear();
                                          controller.selectedRoomes[
                                                  'Night ${nightIndex + 1}'] =
                                              values;

                                          // controller.roomstypesForItinerary[
                                          //         'Night ${nightIndex + 1}'] =
                                          //     values;
                                          log(controller.roomstypesForItinerary
                                              .toString());
                                        },
                                      ),
                                    ),
                                  )),
                              const SizedBox(width: 5),
                            ],
                          ),
                          Obx(() => controller.selectedRoomes[
                                          'Night ${nightIndex + 1}'] !=
                                      null &&
                                  controller
                                      .selectedRoomes[
                                          'Night ${nightIndex + 1}']!
                                      .isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller
                                          .selectedRoomes[
                                              'Night ${nightIndex + 1}']
                                          ?.length ??
                                      0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final SingleRoomModel? room =
                                        controller.selectedRoomes[
                                            'Night ${nightIndex + 1}']?[index];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                                '${room!.roomBuilding} ${room.categoryName} ${room.roomType}',
                                                style: subheading2),
                                          ),
                                        ),
                                        const Text('x'),
                                        Expanded(
                                          child: CustomTextFormField(
                                            keyboardType: TextInputType.number,
                                            labelText: 'Qty',
                                            onChanged: (String value) async {
                                              controller.roomQuantityForItinerary[
                                                      'Night ${nightIndex + 1}']![
                                                  index]['qty'] = value;
                                              controller.roomNameForItinerary[
                                                          'Night ${nightIndex + 1}']![
                                                      index]['room_name'] =
                                                  '${room.categoryName} ${room.roomType}';
                                              log('kmkemkr quantity ${controller.roomQuantityForItinerary}');
                                              log('kmkemkr name ${controller.roomNameForItinerary}');
                                              final List<Map<String, dynamic>>
                                                  roomList =
                                                  controller.itinerarySnapshots[
                                                              'Day ${nightIndex + 1}']![
                                                          'room']
                                                      as List<
                                                          Map<String, dynamic>>;
                                              for (final Map<String,
                                                      dynamic> roomData
                                                  in roomList) {
                                                if (roomData['room_id'] ==
                                                    room.roomId) {
                                                  roomData['room_qty'] = value;
                                                  break;
                                                }
                                              }
                                              log(controller.itinerarySnapshots[
                                                      'Day ${nightIndex + 1}']
                                                  .toString());
                                              final int count =
                                                  int.parse(value);

                                              final String? price = controller
                                                  .selectedRoomes[
                                                      'Night ${nightIndex + 1}']![
                                                      index]
                                                  .roomPrice;
                                              final int sum =
                                                  int.parse(price.toString()) *
                                                      count;

                                              final SingleRoomModel roomKey =
                                                  controller.selectedRoomes[
                                                          'Night ${nightIndex + 1}']![
                                                      index];

                                              controller.roomPrice[
                                                      'Night ${nightIndex + 1}']
                                                  ?[roomKey.roomBuilding
                                                      .toString()] = sum;

                                              for (final SingleRoomModel element
                                                  in controller.selectedRoomes[
                                                      'Night ${nightIndex + 1}']!) {
                                                controller.roomsForItinerary[
                                                        'Night ${nightIndex + 1}']
                                                    ?.add(
                                                        '$value ${element.categoryName} ${element.roomType} room for ${controller.adults.value} pax');
                                                log('knijnij ${controller.roomsForItinerary}');
                                              }
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
      )
    ]);
  }
}
