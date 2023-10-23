import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../core/theme/style.dart';
import '../data/models/network_models/single_vehicle_model.dart';
import '../modules/custom_booking/controllers/custom_booking_controller.dart';
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
            style: subheading2.copyWith(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Obx(() {
            return controller.tourSelected.value
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
        Obx(() => controller.searchingVehicles.value
            ? const LinearProgressIndicator()
            : const SizedBox()),
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
                                      for (int j = 0; j < values.length; j++) {
                                        controller.vehicleQuantityForItinerary[
                                                'Day ${dayIndex + 1}']!
                                            .add(
                                          <String, String>{'qty': ''},
                                        );
                                      }
                                      for (int j = 0; j < values.length; j++) {
                                        controller.vehicleNameForItinerary[
                                                'Day ${dayIndex + 1}']!
                                            .add(
                                          <String, String>{'vehicle_name': ''},
                                        );
                                      }
                                      final List<String> vehIds = <String>[];

                                      for (final String element in values) {
                                        final String? id = controller
                                            .vehicleModel
                                            .firstWhere(
                                                (SingleVehicleModel v) =>
                                                    v.vehicleName == element)
                                            .vehicleId;
                                        vehIds.add(id!);
                                      }
                                      final List<Map<String, dynamic>> vehList =
                                          vehIds.map((String roomId) {
                                        return <String, String?>{
                                          'vehicle_id': roomId,
                                          'vehicle_qty': null,
                                        };
                                      }).toList();

                                      controller.itinerarySnapshots[
                                              'Day ${dayIndex + 1}']![
                                          'vehicle'] = vehList;
                                      log(controller.itinerarySnapshots
                                          .toString());
                                      log('yhn $values');
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
                                                controller.vehicleQuantityForItinerary[
                                                        'Day ${dayIndex + 1}']![
                                                    index]['qty'] = value;
                                                controller.vehicleNameForItinerary[
                                                            'Day ${dayIndex + 1}']![
                                                        index]['vehicle_name'] =
                                                    ' ${controller.selectedVehicles['Day ${dayIndex + 1}']?[index]}';
                                                log('kmkemkr quantity ${controller.vehicleQuantityForItinerary}');
                                                log('kmkemkr name ${controller.vehicleNameForItinerary}');

                                                final List<Map<String, dynamic>>
                                                    vehList =
                                                    controller.itinerarySnapshots[
                                                                'Day ${dayIndex + 1}']![
                                                            'vehicle']
                                                        as List<
                                                            Map<String,
                                                                dynamic>>;
                                                final String vehName = controller
                                                            .selectedVehicles[
                                                        'Day ${dayIndex + 1}']![
                                                    index];
                                                final String? vehId = controller
                                                    .vehicleModel
                                                    .firstWhere(
                                                        (SingleVehicleModel
                                                                element) =>
                                                            element
                                                                .vehicleName ==
                                                            vehName)
                                                    .vehicleId;
                                                for (final Map<String,
                                                        dynamic> vehData
                                                    in vehList) {
                                                  if (vehData['vehicle_id'] ==
                                                      vehId) {
                                                    vehData['vehicle_qty'] =
                                                        value;
                                                    break;
                                                  }
                                                }
                                                log(controller
                                                    .itinerarySnapshots[
                                                        'Day ${dayIndex + 1}']
                                                    .toString());

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
}
