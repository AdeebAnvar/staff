import 'dart:developer';

import '../../../../data/models/network_models/addons_price_model.dart';
import '../../../../data/models/network_models/single_vehicle_model.dart';
import '../../../../data/models/network_models/tours_model.dart';
import '../../../../data/models/network_models/vehcile_category_model.dart';
import '../../../../data/models/network_models/vehicle_checking_model.dart';
import '../../../../data/models/network_models/vehicle_price_model.dart';
import '../../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../../services/dio_client.dart';
import '../../controllers/custom_booking_controller.dart';

class VehicleFunction {
  CustomBookingController controller = CustomBookingController();
  Future<void> getVehicleCategoriesFromApi() async {
    controller.isGettingVehicleCategory.value = true;
    controller.searchingVehicles.value = true;
    final List<String> tourIds = <String>[];
    for (final TourModel element in controller.tours) {
      if (element.tourName!.trim() ==
          controller.selectedTourWithoutTransit.value.trim()) {
        tourIds.add(element.tourId!);
      }
    }
    try {
      final ApiResponse<List<VehcileCategoryModel>> res =
          await CustomBookingRepo().getVehicleCategory(tourIds);
      log('drctfvgyhnj ${res.message}');
      if (res.status == ApiResponseStatus.completed) {
        controller.vehicleCategoryModel.value = res.data!;
        controller.vehicleCtegoryDropDown.clear();
        final Set<String> uniqueValues =
            <String>{}; // Use a set to track unique values
        uniqueValues.clear();

        for (final VehcileCategoryModel vehicle
            in controller.vehicleCategoryModel) {
          if (vehicle.catId != null &&
              !uniqueValues.contains(vehicle.catName.toString())) {
            uniqueValues.add(vehicle.catName.toString());
            controller.vehicleCtegoryDropDown.add(vehicle.catName.toString());
          } else {
            // Debug statement for duplicate value
            // tourPdfEmpty = false;
          }
        }
        controller.searchingVehicles.value = false;
      } else {
        controller.isGettingVehicleCategory.value = false;
        controller.searchingVehicles.value = false;
      }
    } catch (e) {
      controller.searchingVehicles.value = false;
    }
  }

  Future<void> checkVehicleAvailability(
      {required List<String> vehicleCatyegory}) async {
    log('Kiimii 1');
    controller.isCheckingVehicle.value = true;
    controller.searchingVehicles.value = true;
    final List<String> vehicleCatyegoryIds = <String>[];
    for (final String element in vehicleCatyegory) {
      final String id = controller.vehicleCategoryModel
          .firstWhere((VehcileCategoryModel e) => e.catName == element)
          .catId!;
      vehicleCatyegoryIds.add(id);
    }

    try {
      log('Kiimii 2');

      final String tourId = controller.tours
          .firstWhere((TourModel element) =>
              element.tourName == controller.selectedTourWithoutTransit.value)
          .tourId
          .toString();

      // final String tourId = tour.tourId!;
      log('tour id $tourId');

      final VehicleCheckingModel vm = VehicleCheckingModel(
          tourId: tourId, vehicleCategory: vehicleCatyegoryIds);
      final ApiResponse<List<SingleVehicleModel>> res =
          await CustomBookingRepo().checkVehicles(vm);
      log(res.message.toString());
      if (res.data != null) {
        log('Kiimii 3');
        controller.searchingVehicles.value = false;

        controller.vehicleModel.value = res.data!;
        final List<String> allVehicleInpLace = <String>[];
        for (final SingleVehicleModel vehicleModel in controller.vehicleModel) {
          allVehicleInpLace.add(vehicleModel.vehicleName.toString());
        }

        // Use a set to keep track of unique values
        final Set<String> uniqueCarBrands = <String>{};

        for (final String brand in allVehicleInpLace) {
          // Convert brand to lowercase for case-insensitive comparison
          final String lowercaseBrand = brand.toLowerCase();

          if (!uniqueCarBrands.contains(lowercaseBrand)) {
            // Add the lowercase brand to the set if it's not already there
            uniqueCarBrands.add(lowercaseBrand);
            // Add the original brand to the result list
            controller.vehicleTypesDropDown.add(brand);
          }
        }
      } else {
        log('Kiimii 5');
        controller.searchingVehicles.value = false;
      }
    } catch (e) {
      controller.searchingVehicles.value = false;
      log('Kiimii 4');

      controller.checkingAvailabilty.value = false;
      controller.isCheckingVehicle.value = false;
      log('veh $e');
    }
  }

  Future<void> getVehiclePricesinPlaces(String placeId,
      List<String> vehicleNames, List<int> vehicleQty, int dayIndex) async {
    try {
      final List<String> vehicleIds = <String>[];
      for (final String e in vehicleNames) {
        final String id = controller.vehicleModel
            .firstWhere(
                (SingleVehicleModel element) => element.vehicleName == e)
            .vehicleId!;
        vehicleIds.add(id);
      }
      final VehiclePriceModel vpm = VehiclePriceModel(
        placeId: placeId,
        vehicleIds: vehicleIds,
      );
      await CustomBookingRepo()
          .getVehiclesInPlaces(vpm)
          .then((ApiResponse<List<VehiclePriceModel>> res) {
        if (res.data != null && res.data!.isNotEmpty) {
          final List<num> prices = <num>[];
          controller.vehiclePriceModel.value = res.data!;
          for (final VehiclePriceModel price in controller.vehiclePriceModel) {
            prices.add(price.price!);
          }
          final num sum =
              prices.reduce((num value, num element) => value + element);
          controller.allPricesOfVehicle['Day ${dayIndex + 1}'] = sum;
        } else {
          controller.allPricesOfVehicle['Day ${dayIndex + 1}'] = 0;
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getVehiclePricesinAddons(List<String> addonIds,
      List<String> vehicleNames, List<int> vehicleQty, int dayIndex) async {
    try {
      final List<String> vehicleIds = <String>[];
      if (vehicleNames.isNotEmpty) {
        for (final String e in vehicleNames) {
          final String id = controller.vehicleModel
              .firstWhere(
                  (SingleVehicleModel element) => element.vehicleName == e)
              .vehicleId!;
          vehicleIds.add(id);
        }
      }
      final AddonPriceModel apm = AddonPriceModel(
        addonIds: addonIds,
        vehicleIds: vehicleIds,
      );
      await CustomBookingRepo().getVehiclesInAddonss(apm).then(
        (ApiResponse<List<AddonPriceModel>> res) {
          if (res.data != null && res.data!.isNotEmpty) {
            final List<num> prices = <num>[];
            controller.addonPriceModel.value = res.data!;
            for (final AddonPriceModel price in controller.addonPriceModel) {
              prices.add(price.price!);
            }
            final num sum =
                prices.reduce((num value, num element) => value + element);
            controller.allPricesOfAddonVehicle['Day ${dayIndex + 1}'] = sum;
          }
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
