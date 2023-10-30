import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/style.dart';
import '../../../../data/models/network_models/single_room_model.dart';
import '../../../../data/models/network_models/single_vehicle_model.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../controllers/custom_booking_controller.dart';

class Costing {
  CustomBookingController controller = CustomBookingController();
  Future<void> calculateCost({
    required BuildContext context,
  }) async {
    if (controller.placesForSingleDay.length == controller.days.value) {
      final List<String> vehicleNames = <String>[];

      for (final String element in controller.selectedVehicleModel.values) {
        final String vehicleName = controller.vehicleModel
            .firstWhere((SingleVehicleModel veh) => veh.vehicleId == element)
            .vehicleName!;
        vehicleNames.add(vehicleName);
      }
      final List<String> roomNames = <String>[];

      for (final String element in controller.selectedRoomModel.values) {
        final String roomName = controller.roomModel
            .firstWhere((SingleRoomModel rom) => rom.roomBuilding == element)
            .roomBuilding!;
        roomNames.add(roomName);
      }

      final num totalCost = calculateTotalCost(
          controller.roomPrice,
          controller.allPricesOfAddonVehicle,
          controller.allPricesOfVehicle,
          controller.activityAmount,
          controller.foodPrice);
      log('totl $totalCost');
      controller.price = totalCost / controller.adults.value;
      showDialog(
        context: context,
        builder: (BuildContext ctx) => AnimatedContainer(
          duration: const Duration(microseconds: 600),
          child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Package amount : ${controller.price.round()} /pax',
                      style: subheading1.copyWith(fontWeight: FontWeight.bold)),
                  const Text('Advance amount :'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Text('2000 /pax',
                                style: subheading1.copyWith(
                                    fontWeight: FontWeight.bold))),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add)),
                        Expanded(
                          flex: 3,
                          child: CustomTextFormField(
                            keyboardType: TextInputType.number,
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
                        '${controller.advAmount.value + controller.extraAdvAmount.value} /pax',
                        style:
                            subheading1.copyWith(fontWeight: FontWeight.bold));
                  }),
                  const SizedBox(height: 10),
                  Text(
                      'You will get 🪙 ${getPoints(controller.price)} points /pax for this tour ',
                      style: subheading1,
                      textAlign: TextAlign.center),
                  Text(
                      '(*points only rewarded after the booking confirmation )',
                      textAlign: TextAlign.center,
                      style: subheading3),
                ],
              )),
        ),
      );
    } else {
      Get.snackbar("Places didn't added", 'A place must need to add in a day');
    }
  }

  num calculateTotalCost(
    Map<String, Map<String, int>> roomPrices,
    Map<String, num> allPricesOfAddonVehicle,
    Map<String, num> allPricesOfVehicle,
    Map<String, Map<num?, String>> activityAmount,
    Map<String, Map<String, int>> foodPrices,
  ) {
    num totalCost = 0;
    log('vgbhkjml,; roomPrices $roomPrices');
    log('vgbhkjml,;allPricesOfAddonVehicle $allPricesOfAddonVehicle');
    log('vgbhkjml,;allPricesOfVehicle $allPricesOfVehicle');
    log('vgbhkjml,;activityAmount $activityAmount');
    log('vgbhkjml,;activityAmount $controller.selectedFoodsForDays');
    // Iterate through nights and days
    for (final String night in roomPrices.keys) {
      final Map<String, int>? roomPrice = roomPrices[night];

      if (roomPrice != null && roomPrice.isNotEmpty) {
        totalCost += roomPrice.values.reduce((int a, int b) => a + b);
      }
    }
    for (final String day in foodPrices.keys) {
      final Map<String, int>? foodPrice = foodPrices[day];

      if (foodPrice != null && foodPrice.isNotEmpty) {
        totalCost += foodPrice.values.reduce((int a, int b) => a + b);
      }
    }

    for (final String day in allPricesOfAddonVehicle.keys) {
      // Add addon vehicle price for each day
      totalCost += allPricesOfAddonVehicle[day]!;
    }

    for (final String day in allPricesOfVehicle.keys) {
      // Add vehicle price for each day
      totalCost += allPricesOfVehicle[day]!;
    }
    if (activityAmount != null && activityAmount.isNotEmpty) {
      for (final String day in activityAmount.keys) {
        for (final num? amount in activityAmount[day]!.keys) {
          // Convert the activity amount to num before multiplication
          final num activityNum = num.parse(activityAmount[day]![amount]!);
          // Add activity amount for each day
          totalCost += amount! * activityNum;
        }
      }
    }

    return totalCost;
  }

  num getPoints(num price) {
    final num amount = price * 0.03;
    final num points = amount / 20;
    return points.round();
  }
}
