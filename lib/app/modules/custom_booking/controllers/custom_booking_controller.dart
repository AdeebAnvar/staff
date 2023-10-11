// ignore_for_file: unrelated_type_equality_checks, invalid_use_of_protected_member

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/theme/style.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../data/models/local_models/custom_itinerary_model.dart';
import '../../../data/models/network_models/activity_model.dart';
import '../../../data/models/network_models/addons_model.dart';
import '../../../data/models/network_models/addons_price_model.dart';
import '../../../data/models/network_models/checking_rooms_model.dart';
import '../../../data/models/network_models/food_model.dart';
import '../../../data/models/network_models/places_model.dart';
import '../../../data/models/network_models/room_category_model.dart';
import '../../../data/models/network_models/single_room_model.dart';
import '../../../data/models/network_models/single_vehicle_model.dart';
import '../../../data/models/network_models/snapshot_model.dart';
import '../../../data/models/network_models/telecaller_model.dart';
import '../../../data/models/network_models/tours_model.dart';
import '../../../data/models/network_models/vehcile_category_model.dart';
import '../../../data/models/network_models/vehicle_checking_model.dart';
import '../../../data/models/network_models/vehicle_price_model.dart';
import '../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../data/repository/network_repo/tours_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../../../services/dio_download.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/custom_toast.dart';
import '../views/custom_booking_view.dart';

class CustomBookingController extends GetxController
    with StateMixin<CustomBookingView> {
  GlobalKey<FormState> formKey = GlobalKey();
  RxMap<int, String> countForPaxRoomError = <int, String>{}.obs;
  RxMap<int, String> countForPaxVehicleError = <int, String>{}.obs;
  RxInt days = 0.obs;
  RxInt nights = 0.obs;
  RxInt kids = 0.obs;
  RxInt infants = 0.obs;
  RxInt adults = 0.obs;
  RxBool tourSelecting = false.obs;
  RxBool tourSelected = false.obs;
  RxString selectedRoomCategory = RxString('');
  RxString selectedVehicleCategory = RxString('');
  ItineraryRooms itineraryRoomsMoDEL = ItineraryRooms();
  ItineraryVehicles itineraryVehiclesmodel = ItineraryVehicles();
  String? tourStartingDateTime;
  String? tourEndingDateTime;
  Map<String, List<String>> activitiesForSingleDayName =
      <String, List<String>>{};
  Map<String, List<String>> addonsForSingleDayName = <String, List<String>>{};
  Map<String, List<String>> placesForSingleDayName = <String, List<String>>{};
  RxMap<int, String> selectedTransitDays = <int, String>{}.obs;
  RxMap<int, bool> isCheckedTransitDays = <int, bool>{}.obs;
  RxMap<int, bool> isCheckedRoomTypes = <int, bool>{}.obs;
  RxMap<int, bool> isCheckedVehicleTypes = <int, bool>{}.obs;
  RxMap<int, bool> isCheckedRoomModel = <int, bool>{}.obs;
  RxMap<int, bool> isCheckedRoomCategories = <int, bool>{}.obs;
  RxBool isTransit = false.obs;
  RxBool notAddedTransitDays = false.obs;
  List<String> allrooms = <String>[];
  RxList<String> transitDays = <String>[].obs;
  RxList<RoomCategoryModel> roomCategoryModel = <RoomCategoryModel>[].obs;
  Rx<int> isSelectedTab = 0.obs;
  RxMap<int, String> selectedTourWithTransit = <int, String>{}.obs;
  RxMap<int, bool> isSelectedRoom = <int, bool>{}.obs;
  RxMap<int, bool> isSelectVehicle = <int, bool>{}.obs;
  RxList<String> selectedRoomTypes = <String>[].obs;
  RxList<String> selectedVehicleTypes = <String>[].obs;
  RxMap<String, List<SingleRoomModel>> selectedRoomes =
      <String, List<SingleRoomModel>>{}.obs;
  RxMap<String, List<String>> selectedVehicles = <String, List<String>>{}.obs;
  RxMap<int, String> selectedRoomModel = <int, String>{}.obs;
  RxMap<int, String> selectedVehicleModel = <int, String>{}.obs;
  RxList<int> selectedRoomCategories = <int>[].obs;
  RxString selectedTourWithoutTransit = RxString('');
  RxString notSelectedWithoutTransitTour = RxString('');
  RxBool firstPhaseCompleted = false.obs;
  RxList<VehcileCategoryModel> vehicleCategoryModel =
      <VehcileCategoryModel>[].obs;
  RxMap<String, int> roomQTY = <String, int>{}.obs;
  RxMap<String, int> vehicleQTY = <String, int>{}.obs;
  GetStorage storage = GetStorage();
  RxMap<String, Map<int, bool>> isCheckedVehicleAddonPrice =
      <String, Map<int, bool>>{}.obs;
  RxMap<String, Map<int, bool>> isCheckedVehicleDayTourPrice =
      <String, Map<int, bool>>{}.obs;
  RxMap<String, Map<int, bool>> isCheckedVehicleDropOffPrice =
      <String, Map<int, bool>>{}.obs;
  RxMap<String, Map<int, bool>> isCheckedVehiclePickupPrice =
      <String, Map<int, bool>>{}.obs;
  RxMap<String, List<PlacesModel>> dummyvalue =
      <String, List<PlacesModel>>{}.obs;
  RxMap<String, List<SingleRoomModel>> selectedRoomForaday =
      <String, List<SingleRoomModel>>{}.obs;
  RxMap<String, List<String>> selectedRoomCostsForaday =
      <String, List<String>>{}.obs;
  RxMap<String, List<AddonsModel>> selectedAddonsForaday =
      <String, List<AddonsModel>>{}.obs;
  RxMap<String, List<FoodModel>> selectedFoodForaday =
      <String, List<FoodModel>>{}.obs;
  RxMap<String, List<SingleVehicleModel>> selectedVehicleForaday =
      <String, List<SingleVehicleModel>>{}.obs;
  RxMap<String, List<ActivityModel>> selectedActivityForaday =
      <String, List<ActivityModel>>{}.obs;
  String? depId;
  String? branchId;
  String? tourId;
  String placeId = '';
  final RxString notSelectedTour = RxString('');
  RxString selectedOption = 'No Transit'.obs;
  String? customerId;
  String? customerName;
  RxMap<String, Map<String, int>> vehicleQuantity =
      <String, Map<String, int>>{}.obs;
  RxList<String> tourValues = RxList<String>(<String>['']);
  RxList<String> addonValues = RxList<String>(<String>['']);
  RxList<String> placeValues = RxList<String>(<String>['']);
  RxList<String> activityValues = RxList<String>(<String>['']);
  RxList<String> foodTypeValues = RxList<String>(<String>['']);
  RxList<int> dayIndexes = <int>[].obs;
  final RxMap<dynamic, dynamic> selectedAddonValues = <dynamic, dynamic>{}.obs;
  final RxMap<dynamic, dynamic> selectedFoodTypeValues =
      <dynamic, dynamic>{}.obs;
  final RxMap<int, String> selectedActivityValues = <int, String>{}.obs;
  final RxMap<int, String> paxCountForRoom = <int, String>{}.obs;
  final RxMap<int, String> paxCountForVehicle = <int, String>{}.obs;
  final RxMap<int, SingleRoomModel> confirmedRooms =
      <int, SingleRoomModel>{}.obs;
  final RxMap<int, SingleVehicleModel> confirmedVehicles =
      <int, SingleVehicleModel>{}.obs;
  RxBool checkingAvailabilty = false.obs;
  RxList<TourModel> tours = <TourModel>[].obs;
  RxList<SingleRoomModel> roomModel = <SingleRoomModel>[].obs;
  RxMap<String, List<ActivityModel>> activityModel =
      <String, List<ActivityModel>>{}.obs;
  RxMap<String, List<AddonsModel>> addonsModel =
      <String, List<AddonsModel>>{}.obs;
  RxList<PlacesModel> placesModel = <PlacesModel>[].obs;
  RxList<FoodModel> foodModel = <FoodModel>[].obs;
  RxList<SingleVehicleModel> vehicleModel = <SingleVehicleModel>[].obs;
  List<String?> vehiclePrices = <String?>[];
  RxMap<String, List<SingleVehicleModel>> vehiclesForSingleDay =
      <String, List<SingleVehicleModel>>{}.obs;
  final RxMap<int, bool> confirmedBoolienRoomList = <int, bool>{}.obs;
  final RxMap<int, bool> confirmedBoolienVehicleList = <int, bool>{}.obs;
  RxMap<String, Map<String, Map<String, bool>>> vehicleAmounts =
      <String, Map<String, Map<String, bool>>>{}.obs;
  RxBool searchingRooms = false.obs;
  RxBool searchingVehicles = false.obs;
  RxBool searchingFood = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await loadData();

    log('njnkml, $depId');
    roomTypesDropDown.clear();
  }

  String get selecteOption => selectedOption.value;

  set selecteOption(String option) {
    selectedOption.value = option;
  }

  void itemChangeOnTransitDay(int index, bool value) {
    if (isCheckedTransitDays[index] != true) {
      selectedTransitDays[index] = 'Day ${index + 1}';
      isCheckedTransitDays[index] = value;
      dayIndexes.add(index);
    } else {
      selectedTransitDays.remove(index);
      dayIndexes.remove(index);
      isCheckedTransitDays[index] = value;
      dayIndexes.remove(index);
    }
    log('day ind $dayIndexes');
    log('checked tr $isCheckedTransitDays');
    log('selected tra $selectedTransitDays');
  }

  String depImage = '';
  void itemChangeOnRoomType(int index, bool value) {
    if (isCheckedRoomTypes[index] != true) {
      selectedRoomTypes[index] = roomTypes[index];
      isCheckedRoomTypes[index] = value;
    } else {
      selectedRoomTypes.remove(index.toString());
      isCheckedRoomTypes[index] = value;
    }
    log(selectedRoomTypes.toString());
  }

  TeleCallerModel telecaCaller = TeleCallerModel();
  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      tours.value = Get.arguments[0] as List<TourModel>;
      customerId = Get.arguments[1] as String;
      customerName = Get.arguments[2] as String;
      tourValues.clear();
      depId = await storage.read('depID') as String;
      branchId = await storage.read('branchID') as String;
      depImage = await storage.read('depImage') as String;
      telecaCaller = await storage.read('telecaller_data') as TeleCallerModel;

      await loadTours();

      change(null, status: RxStatus.success());
    }
  }

  Future<void> loadTours() async {
    try {
      final ApiResponse<List<TourModel>> response =
          await ToursRepository().getAllToursInDepartment(depId.toString());
      if (response.data != null && response.data!.isNotEmpty) {
        tours.value = response.data!;
        final Set<String> uniqueValues =
            <String>{}; // Use a set to track unique values

        for (final TourModel tour in tours) {
          if (tour.tourCode != null && !uniqueValues.contains(tour.tourCode)) {
            uniqueValues.add(tour.tourName!);

            tourValues.add(tour.tourName!);
          } else {
            log('Duplicate tourCode found: ${tour.tourCode}');
          }
        }

        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
        // Debug statement for duplicate value
        // tourPdfEmpty = false;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getAddons(String placeId, String index) async {
    try {
      final ApiResponse<List<AddonsModel>> res =
          await CustomBookingRepo().getAddons(placeId);

      if (res.data!.isNotEmpty) {
        addonsModel[index] = res.data!;
        addonValues.clear();
        log('bhjj ${res.data}');
        // final Set<String> uniqueValues =
        //     <String>{}; // Use a set to track unique values
        // final List<AddonsModel> addons = addonsModel;

        // for (final AddonsModel addons in addons) {
        //   if (addons.addonName != null &&
        //       !uniqueValues.contains(addons.addonName)) {
        //     uniqueValues.add(addons.addonName!);

        //     addonValues.add(addons.addonName!);
        //   } else {}
        // }
      } else {
        CustomToastMessage().showCustomToastMessage('No addons found');
      }
    } catch (e) {
      log('room $e');
    }
  }

  RxMap<String, PlacesModel> placesForItinerary = <String, PlacesModel>{}.obs;
  RxMap<String, List<String>> vehiclesForItinerary =
      <String, List<String>>{}.obs;
  RxMap<String, List<String>> vehiclestypForItinerary =
      <String, List<String>>{}.obs;
  RxMap<String, List<AddonsModel>> addonsForItinerary =
      <String, List<AddonsModel>>{}.obs;
  RxMap<String, List<ActivityModel>> activitiesForItinerary =
      <String, List<ActivityModel>>{}.obs;
  RxMap<String, List<String>> activitiespaxForItinerary =
      <String, List<String>>{}.obs;
  RxMap<String, List<String>> roomsForItinerary = <String, List<String>>{}.obs;
  RxMap<String, List<String>> roomstypesForItinerary =
      <String, List<String>>{}.obs;

  Future<void> getActivities(String placeId, String index) async {
    if (activityModel.containsKey(index)) {
      activityModel[index]!.clear();
    }
    try {
      final ApiResponse<List<ActivityModel>> res =
          await CustomBookingRepo().getActivities(placeId);

      if (res.data!.isNotEmpty) {
        activityModel[index] = res.data!;

        log('yuyvvyyv kj$activityModel');
        log('yuyvvyyv kje$placeId');
        activityValues.clear();

        // final Set<String> uniqueValues = <String>{};
        // for (final String placeId in activityModel.value) {
        //   final List<ActivityModel> activities = activityModel[placeId]!;

        //   for (final ActivityModel activity in activities) {
        //     if (activity.activityName != null &&
        //         !uniqueValues.contains(activity.activityName)) {
        //       uniqueValues.add(activity.activityName!);
        //       activityValues.add(activity.activityName!);
        //     }
        //   }
        // }
      } else {
        CustomToastMessage().showCustomToastMessage('No activities found');
      }
    } catch (e) {
      log('room $e');
    }
  }

  Future<void> getFoods() async {
    try {
      searchingFood.value = true;
      final String tourId = tours.value
          .firstWhere((TourModel element) =>
              element.tourName == selectedTourWithoutTransit.value)
          .tourId!;
      final ApiResponse<List<FoodModel>> res =
          await CustomBookingRepo().getFoods(tourId);

      if (res.data!.isNotEmpty) {
        foodModel.value = res.data!;
        searchingFood.value = false;

        // final Set<String> uniqueValues =
        //     <String>{}; // Use a set to track unique values

        // for (final FoodModel food in foodModel['Day ${index + 1}']!) {
        //   if (food.foodType != null && !uniqueValues.contains(food.foodType)) {
        //     uniqueValues.add(food.foodType!);
        //     foodTypeValues.add(food.foodType!);
        //   } else {}
        // }
      } else {
        searchingFood.value = false;

        // CustomToastMessage().showCustomToastMessage('No f found');
      }
    } catch (e) {
      searchingFood.value = false;

      log('room $e');
    }
  }

  Future<void> selectRoomContainer(int index, int id) async {
    final bool isSelected = confirmedBoolienRoomList[index] ?? false;

    if (isSelected) {
      confirmedRooms
          .remove(index); // Remove the room from the confirmedRooms map
      confirmedBoolienRoomList[index] = false; // Mark as unselected
    } else {
      confirmedRooms[index] =
          roomModel[index]; // Add the room to the confirmedRooms map
      confirmedBoolienRoomList[index] = true; // Mark as selected
    }
    log(confirmedRooms.toString());
    update(<int>[id, index]);
  }

  // final Tour tour = Tour(
  //   roomBuilding: roomModel[index].roomNumber.toString(),
  //   roomCategory: roomModel[index].roomBuilding.toString(),
  //   roomId: roomModel[index].roomId,
  //   roomNumber: roomModel[index].roomNumber.toString(),
  //   roomPrice: roomModel[index].roomPrice,
  // );
  // await storage.write('tour', tour);
  // room = await storage.read('tour') as Tour;
  void selectVehicleContainer(int index, int id) {
    final bool isSelected = confirmedBoolienVehicleList[index] ?? false;

    if (isSelected) {
      confirmedVehicles
          .remove(index); // Remove the room from the confirmedRooms map
      confirmedBoolienVehicleList[index] = false; // Mark as unselected
    } else {
      confirmedVehicles[index] =
          vehicleModel[index]; // Add the room to the confirmedVehicles map
      confirmedBoolienVehicleList[index] = true; // Mark as selected
    }
    log(confirmedVehicles.toString());
    update(<int>[id, index]);
  }

  void onPlaceChanged(int index, String? value) {
    update(<int>[index]);

    log('Selected place for day ${index + 1}: ${value ?? ''}');
  }

  void onAddonChanged(int index, String? value) {
    selectedAddonValues[index] = value;
    update(<int>[index]);
  }

  void onFoodChanged(int index, String? value) {
    selectedFoodTypeValues[index] = value;
    update(<int>[index]);
  }

  void onActivityChanged(int index, String? value) {
    selectedActivityValues[index] = value.toString();
    log('Selected activity for day ${index + 1}: ${value ?? ''}');
  }

  String? validateSelectedTourStartingDateTime(String? value) =>
      DateTime.tryParse(value ?? '') != null
          ? null
          : 'Add Tour Starting Date and Time';

  String? validateSelectedTourEndingDateTime(String? value) =>
      DateTime.tryParse(value ?? '') != null
          ? null
          : 'Add Tour Ending Date and Time';

  String? validateTotalTourDays(String? p0) =>
      p0!.isEmpty ? 'add total tour days' : null;

  String? validateDaysofTour(String? p0) =>
      p0!.isEmpty ? 'add tour days' : null;

  String? validateNightsofTour(String? p0) =>
      p0!.isEmpty ? 'add tour nights' : null;

  String? validateAdultsCount(String? p0) =>
      p0!.isEmpty ? 'add total adult count' : null;

  String? validateKidsCount(String? p0) =>
      p0!.isEmpty ? 'add total kids count' : null;
  String? validateInfantsCount(String? p0) =>
      p0!.isEmpty ? 'add total infants count' : null;

  List<SingleRoomModel> selectedRoomsForDropDown = <SingleRoomModel>[];
  List<SingleVehicleModel> selectedVehicleForDropDown = <SingleVehicleModel>[];
  Rx<bool> onClickGenerateItinerary = false.obs;
  Future<void> onClickCreateItinerary() async {
    onClickGenerateItinerary.value = true;

    log(' k 1');
    if (formKey.currentState!.validate()) {
      if (isTransit.value) {
        // transit tour
        log(' k 2');
      } else {
        // non transit tour
        log(' k 3');

        if (selectedTourWithoutTransit.isNotEmpty) {
          // final DateTime date1 =
          //     DateTime.parse(tourStartingDateTime.toString());
          // final DateTime date2 = DateTime.parse(tourEndingDateTime.toString());
          // final Duration totalDaysNeeded =
          //     date2.difference(date1) + const Duration(days: 1);
          // final int totalDaysAdded = days.value;
          // log('date 1 $date1');
          // log('date 2 $date2');
          // log('date diff  ${date2.difference(date1).inDays}');
          final DateTime date1 = DateTime.parse(
              tourStartingDateTime.toString().toDateOnly().toString());
          final DateTime date2 = DateTime.parse(
              tourEndingDateTime.toString().toDateOnly().toString());

// Calculate the difference in full 24-hour days
          final Duration tdays = date2.isAfter(date1)
              ? date2.difference(date1)
              : date1.difference(date2);
          final Duration totalDaysNeeded = tdays + const Duration(days: 1);
          final int totalDaysAdded = days.value;

          log('date 1 ${date1.day}');
          log('date 2 ${date2.day}');
          log('date diff in totalDaysAdded $totalDaysAdded');
          log('date diff in days ${totalDaysNeeded.inDays}');

          if (totalDaysNeeded.inDays != totalDaysAdded) {
            log(' k 20');

            CustomToastMessage().showCustomToastMessage('Dates not matched');
            onClickGenerateItinerary.value = false;
          } else {
            log(' k 21');

            for (int i = 0; i < days.value; i++) {
              transitDays.add('Day ${i + 1}');
            }
            selectedVehicleModel.forEach((int key, String value) {
              final SingleVehicleModel veh = vehicleModel.firstWhere(
                  (SingleVehicleModel veh) => veh.vehicleId == value,
                  orElse: () => SingleVehicleModel());
              if (veh != null) {
                selectedVehicleForDropDown.add(veh);
                log(' k 22');
              }
            });

            selectedRoomModel.forEach((int key, String value) {
              final SingleRoomModel room = roomModel.firstWhere(
                  (SingleRoomModel room) => room.roomBuilding == value);
              if (room != null) {
                selectedRoomsForDropDown.add(room);
                log(' k 23');
              }
            });

            final String tourId = tours.value
                .firstWhere((TourModel element) =>
                    element.tourName == selectedTourWithoutTransit.value)
                .tourId!;

            await getPlaces(tourId);
            final List<String> roomIds = roomQTY.entries
                .toList()
                .map((MapEntry<String, int> e) => e.key)
                .toList();
            final List<int> roomQtys = roomQTY.entries
                .toList()
                .map((MapEntry<String, int> e) => e.value)
                .toList();
            final ItineraryRooms itineraryRooms = ItineraryRooms(
              roomId: roomIds,
              qty: roomQtys,
            );
            final List<String> vehIds = vehicleQTY.entries
                .toList()
                .map((MapEntry<String, int> e) => e.key)
                .toList();
            final List<int> vehiQty = vehicleQTY.entries
                .toList()
                .map((MapEntry<String, int> e) => e.value)
                .toList();
            final ItineraryVehicles itineraryVehicles = ItineraryVehicles(
              vehicleId: vehIds,
              qty: vehiQty,
            );
            itineraryRoomsMoDEL.qty = itineraryRooms.qty;
            itineraryRoomsMoDEL.roomId = itineraryRooms.roomId;
            itineraryVehiclesmodel.qty = itineraryVehicles.qty;
            itineraryVehiclesmodel.vehicleId = itineraryVehicles.vehicleId;
            firstPhaseCompleted.value = true;
            onClickGenerateItinerary.value = false;
          }
          // tour not selected    \\
          //   log(' k 4');

          //   CustomToastMessage().showCustomToastMessage('No tour selected');
          //   onClickGenerateItinerary.value = false;
          // } else if (selectedRoomModel.isEmpty) {
          //   // no rooms selected
          //   isSelectedTab.value = 0;
          //   log(' k 5');

          //   CustomToastMessage().showCustomToastMessage('No room selected');
          //   onClickGenerateItinerary.value = false;
          // } else if (paxCountForRoom.isEmpty) {
          //   // pax for room sn't given
          //   log(' k 6');

          //   CustomToastMessage()
          //       .showCustomToastMessage('No pax added to any rooms');
          //   onClickGenerateItinerary.value = false;
          // } else {
          //   log(' k 7');

          //   int totalPax = 0;
          //   final List<String> assignedPax = paxCountForRoom.entries
          //       .toList()
          //       .map((MapEntry<int, String> e) => e.value)
          //       .toList();
          //   for (final String str in assignedPax) {
          //     final int? value = int.tryParse(str);
          //     if (value != null) {
          //       totalPax += value;
          //       log(' k 8');
          //     }
          //   }
          //   log(' k 9');

          //   if (totalPax != adults.value) {
          //     log(' k 10');

          //     CustomToastMessage()
          //         .showCustomToastMessage('check added pax in rooms');
          //     onClickGenerateItinerary.value = false;
          //   } else if (selectedVehicleModel.isEmpty) {
          //     // no vehicle selected
          //     log(' k 11');

          //     isSelectedTab.value = 1;
          //     CustomToastMessage().showCustomToastMessage('No vehicle selected');
          //     onClickGenerateItinerary.value = false;
          //   } else if (paxCountForVehicle.isEmpty) {
          //     // pax for vehicle isn't given
          //     log(' k 12');

          //     CustomToastMessage()
          //         .showCustomToastMessage('check added pax in vehicles');
          //     onClickGenerateItinerary.value = false;
          //   } else {
          //     log(' k 13');

          //     int totalPax = 0;
          //     final List<String> assignedPax = paxCountForVehicle.entries
          //         .toList()
          //         .map((MapEntry<int, String> e) => e.value)
          //         .toList();
          //     for (final String str in assignedPax) {
          //       final int? value = int.tryParse(str);
          //       if (value != null) {
          //         totalPax += value;
          //         log(' k 14');
          //       }
          //     }
          //     final int pax = adults.value + kids.value;
          //     if (paxCountForVehicle.length != selectedVehicleModel.length) {
          //       log(' k 15');
          //       log(paxCountForVehicle.toString());
          //       log(selectedVehicleModel.toString());
          //     } else {
          //       if (paxCountForRoom.length != selectedRoomModel.length) {
          //         log(' k 16');
          //       } else {
          //         log(' k 17');

          //         if (totalPax > pax || totalPax < pax) {
          //           log(' k 18');

          //           CustomToastMessage()
          //               .showCustomToastMessage('check added pax in vehicle');
          //           onClickGenerateItinerary.value = false;
          //         } else {
          //           log(' k 19');
        }
      }
    } else {
      onClickGenerateItinerary.value = false;

      CustomToastMessage().showCustomToastMessage('Fields are mandatory');
    }
  }

  Rx<bool> isCheckingPlaces = false.obs;
  Future<void> getPlaces(String tourId) async {
    isCheckingPlaces.value = true;
    // placesModel.value.clear();
    // placeValues.clear();
    log(tourId);
    try {
      final ApiResponse<List<PlacesModel>> response =
          await CustomBookingRepo().getPlaces(tourId);

      log(response.message.toString());

      if (response.data != null && response.data!.isNotEmpty) {
        placesModel.value = response.data!;
        // for (int i = 0; i < response.data!.length; i++) {
        //   isSelectedPlaces['Day ${index + 1}'] = false;
        // }
        // log(isSelectedPlaces.toString());
        placeValues.clear();

        final Set<String> uniqueValues =
            <String>{}; // Use a set to track unique values
        final List<PlacesModel> places = placesModel;

        for (final PlacesModel places in places) {
          if (places.placeName != null &&
              !uniqueValues.contains(places.placeName)) {
            uniqueValues.add(places.placeName!);

            placeValues.add(places.placeName!);
          } else {}
        }
        isCheckingPlaces.value = false;

        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
        isCheckingPlaces.value = false;
      }
    } catch (e) {
      log(e.toString());
      isCheckingPlaces.value = false;

      change(null, status: RxStatus.empty());
    }
  }

  Rx<bool> isCheckingRoomCategory = false.obs;
  RxList<String> roomCategoryDropDown = RxList<String>(<String>['']);

  Future<void> getRoomCategoriesFromApi() async {
    isCheckingRoomCategory.value = true;
    searchingRooms.value = true;
    final List<String> tourIds = <String>[];
    for (final TourModel element in tours) {
      if (element.tourName!.trim() == selectedTourWithoutTransit.value.trim()) {
        tourIds.add(element.tourId!);
      }
    }
    try {
      final ApiResponse<List<RoomCategoryModel>> res =
          await CustomBookingRepo().getRoomCategory(tourIds);
      if (res.status == ApiResponseStatus.completed) {
        roomCategoryModel.value = res.data!;
        roomCategoryDropDown.clear();
        final Set<String> uniqueValues =
            <String>{}; // Use a set to track unique values
        uniqueValues.clear();

        for (final RoomCategoryModel room in roomCategoryModel) {
          if (room.catId != null &&
              !uniqueValues.contains(room.catName.toString())) {
            uniqueValues.add(room.catName.toString());
            roomCategoryDropDown.add(room.catName.toString());
          } else {
            // Debug statement for duplicate value
            // tourPdfEmpty = false;
            searchingRooms.value = false;
          }
        }
        isCheckingRoomCategory.value = false;
        searchingRooms.value = false;
      } else {
        isCheckingRoomCategory.value = false;
        searchingRooms.value = false;
      }
    } catch (e) {
      isCheckingRoomCategory.value = false;
      searchingRooms.value = false;
    }
  }

  Rx<bool> isGettingVehicleCategory = false.obs;
  RxList<String> vehicleCtegoryDropDown = RxList<String>(<String>['']);

  Future<void> getVehicleCategoriesFromApi() async {
    isGettingVehicleCategory.value = true;
    searchingVehicles.value = true;
    final List<String> tourIds = <String>[];
    for (final TourModel element in tours) {
      if (element.tourName!.trim() == selectedTourWithoutTransit.value.trim()) {
        tourIds.add(element.tourId!);
      }
    }
    try {
      final ApiResponse<List<VehcileCategoryModel>> res =
          await CustomBookingRepo().getVehicleCategory(tourIds);
      log('drctfvgyhnj ${res.message}');
      if (res.status == ApiResponseStatus.completed) {
        vehicleCategoryModel.value = res.data!;
        vehicleCtegoryDropDown.clear();
        final Set<String> uniqueValues =
            <String>{}; // Use a set to track unique values
        uniqueValues.clear();

        for (final VehcileCategoryModel vehicle in vehicleCategoryModel) {
          if (vehicle.catId != null &&
              !uniqueValues.contains(vehicle.catName.toString())) {
            uniqueValues.add(vehicle.catName.toString());
            vehicleCtegoryDropDown.add(vehicle.catName.toString());
            log('drctfvgyhnj $vehicleCtegoryDropDown');
          } else {
            // Debug statement for duplicate value
            // tourPdfEmpty = false;
          }
        }
        searchingVehicles.value = false;
      } else {
        isGettingVehicleCategory.value = false;
        searchingVehicles.value = false;
      }
    } catch (e) {
      searchingVehicles.value = false;
    }
  }

  Rx<bool> isGettingRooms = false.obs;
  RxMap<String, int> selectedRoomTypePrices = <String, int>{}.obs;
  RxList<SingleRoomModel> selectedRoomTypeNamesToDropDown =
      <SingleRoomModel>[].obs;
  RxList<String> selectedRoomTypeNames = <String>[].obs;
  Future<void> getRooms(
      List<String> roomtypes, List<String> roomCategories) async {
    isGettingRooms.value = true;

    // await checkToursInTransit(roomCategories: roomCategories, roomTypes: rt);
    await checkToursNonTransit(
            roomCategories: roomCategories, roomTypes: roomtypes)
        .then((value) => isGettingRooms.value = false);

    // final RoomsCheckingModel rm = RoomsCheckingModel(
    //   tourId: tourId,
    //   roomCategories: selectedRoomTypeValues.entries
    //       .toList()
    //       .map((MapEntry<int, String> e) => e.value)
    //       .toList(),
    //   roomTypes: selectedRoomCategoryValues.entries
    //       .toList()
    //       .map((MapEntry<int, String> e) => e.value)
    //       .toList(),
    // );

    // final ApiResponse<List<SingleRoomModel>> res =
    //     await CustomBookingRepo().checkRooms(rm);

    // if (res.data!.isNotEmpty) {
    //   roomModel.value = res.data!;

    //   await checkVehicleAvailability();
    // } else {
    //   checkingAvailabilty.value = false;

    //   CustomToastMessage().showCustomToastMessage('No rooms found');
    // }
  }

  RxList<String> vehicleTypesDropDown = <String>[].obs;
  Rx<bool> isCheckingVehicle = false.obs;
  Future<void> checkVehicleAvailability(
      {required List<String> vehicleCatyegory}) async {
    log('Kiimii 1');
    isCheckingVehicle.value = true;
    final List<String> vehicleCatyegoryIds = <String>[];
    for (final String element in vehicleCatyegory) {
      final String id = vehicleCategoryModel
          .firstWhere((VehcileCategoryModel e) => e.catName == element)
          .catId!;
      vehicleCatyegoryIds.add(id);
    }

    try {
      log('Kiimii 2');

      final String tourId = tours
          .firstWhere((TourModel element) =>
              element.tourName == selectedTourWithoutTransit.value)
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

        vehicleModel.value = res.data!;
        final List<String> allVehicleInpLace = <String>[];
        for (final SingleVehicleModel vehicleModel in vehicleModel.value) {
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
            vehicleTypesDropDown.add(brand);
          }
        }

        log(vehicleTypesDropDown.value.toString());
        log('vehicleTypesDropDown.value.toString()');
      } else {
        log('Kiimii 5');
      }
    } catch (e) {
      log('Kiimii 4');

      checkingAvailabilty.value = false;
      isCheckingVehicle.value = false;
      log('veh $e');
    }
  }

  Future<void> checkToursInTransit(
      {required List<int> roomCategories,
      required List<String> roomTypes}) async {
    if (selectedTourWithTransit.isNotEmpty) {
      for (final String tourCode in selectedTourWithTransit.values) {
        try {
          final TourModel tour = tours
              .firstWhere((TourModel element) => element.tourName == tourCode);

          final String tourId = tour.tourId!;
          log('single not tour $tourId');
          final RoomsCheckingModel rm = RoomsCheckingModel(
              tourId: tourId,
              roomCategories: roomCategories,
              roomTypes: roomTypes);

          final ApiResponse<List<SingleRoomModel>> res =
              await CustomBookingRepo().checkRooms(rm);

          if (res.data!.isNotEmpty) {
            roomModel.value = res.data!;

            // await checkVehicleAvailability();
          } else {
            checkingAvailabilty.value = false;

            CustomToastMessage().showCustomToastMessage('No rooms found');
          }
          // Now you have the tourId, you can make the API call using this value
        } catch (e) {
          // Handle any errors if tour code doesn't match or other issues
          log('Error fetching tourId for tourCode $tourCode: $e');
        }
      }
    }
  }

  RxMap<String, Map<String, int>> roomPrice = <String, Map<String, int>>{}.obs;
  RxMap<String, Map<String, int>> vehiclePrice =
      <String, Map<String, int>>{}.obs;

  Future<void> checkToursNonTransit(
      {required List<String> roomCategories,
      required List<String> roomTypes}) async {
    if (selectedTourWithoutTransit.isNotEmpty) {
      final TourModel matchingTour = tours.firstWhere(
        (TourModel element) =>
            element.tourName == selectedTourWithoutTransit.value,
        orElse: () =>
            TourModel(depId: ''), // Return null if no matching element is found
      );
      // roomCategories =[A/C]
      // roomTypes=[2 shared,4 shared

      final List<int> roomcatId = <int>[];

      for (final String roomc in roomCategories) {
        log('grgtht $roomCategoryModel');
        log('grgthtf $roomCategories');

        roomcatId.add(int.parse(roomc.trimLeft()));
      }

      if (matchingTour != null) {
        final String toursId = matchingTour.tourId.toString();
        log('tethbe $toursId');
        final RoomsCheckingModel rm = RoomsCheckingModel(
            tourId: toursId, roomCategories: roomcatId, roomTypes: roomTypes);

        final ApiResponse<List<SingleRoomModel>> res =
            await CustomBookingRepo().checkRooms(rm);

        if (res.data!.isNotEmpty) {
          roomModel.value = res.data!;

          // await checkVehicleAvailability();
        } else {
          checkingAvailabilty.value = false;

          CustomToastMessage().showCustomToastMessage('No rooms found');
        }
      } else {
        // Handle the case when no matching element is found
        log('No element found for tourCode: ${selectedTourWithoutTransit.value}');
      }
    }
  }

  RxList<String> toursIds = <String>[].obs;
  Future<void> getToursIds() async {
    if (selectedTourWithTransit.isNotEmpty) {}
    if (selectedTourWithoutTransit.isNotEmpty) {
      final TourModel matchingTour = tours.firstWhere(
        (TourModel element) =>
            element.tourName == selectedTourWithoutTransit.value,
        orElse: () =>
            TourModel(depId: ''), // Return null if no matching element is found
      );

      if (matchingTour != null) {
        final String toursId = matchingTour.tourId.toString();
        log('tethbe $toursId');
        toursIds.add(toursId);
      } else {
        // Handle the case when no matching element is found
        log('No element found for tourCode: ${selectedTourWithoutTransit.value}');
      }
    }
  }

  void modifyList(List<String> list, List<int> positions, List<String> values) {
    for (int i = 0; i < positions.length; i++) {
      final int position = positions[i];
      final String value = values[i];

      for (int j = position; j < list.length; j++) {
        list[j] = value;
      }
    }
  }

  var price;
  RxInt advAmount = 2000.obs;
  RxInt extraAdvAmount = 0.obs;
  Future<void> calculateCost({
    required BuildContext context,
  }) async {
    log('guhj ${placesForSingleDay.length}');
    if (placesForSingleDay.length == days.value) {
      final List<String> vehicleNames = <String>[];

      for (final String element in selectedVehicleModel.values) {
        final String vehicleName = vehicleModel
            .firstWhere((SingleVehicleModel veh) => veh.vehicleId == element)
            .vehicleName!;
        vehicleNames.add(vehicleName);
      }
      final List<String> roomNames = <String>[];

      for (final String element in selectedRoomModel.values) {
        final String roomName = roomModel
            .firstWhere((SingleRoomModel rom) => rom.roomBuilding == element)
            .roomBuilding!;
        roomNames.add(roomName);
      }
      final String tourId = tours
          .firstWhere((TourModel element) =>
              element.tourName == selectedTourWithoutTransit.value)
          .tourId
          .toString();

      final num totalCost = calculateTotalCost(roomPrice,
          allPricesOfAddonVehicle, allPricesOfVehicle, activityAmount.value);
      log('totl $totalCost');
      price = totalCost / adults.value;
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
                  Text('Package amount : $price /pax',
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
                              extraAdvAmount.value = int.parse(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text('Total advance amount'),
                  Obx(() {
                    return Text(
                        '${advAmount.value + extraAdvAmount.value} /pax',
                        style:
                            subheading1.copyWith(fontWeight: FontWeight.bold));
                  })
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
      Map<String, Map<num?, String>> activityAmount) {
    num totalCost = 0;
    log('vgbhkjml,; roomPrices $roomPrices');
    log('vgbhkjml,;allPricesOfAddonVehicle $allPricesOfAddonVehicle');
    log('vgbhkjml,;allPricesOfVehicle $allPricesOfVehicle');
    log('vgbhkjml,;activityAmount $activityAmount');
    // Iterate through nights and days
    for (final String night in roomPrices.keys) {
      final Map<String, int>? roomPrice = roomPrices[night];

      if (roomPrice != null && roomPrice.isNotEmpty) {
        totalCost += roomPrice.values.reduce((int a, int b) => a + b);
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

  RxList<String> roomTypes = <String>[].obs;
  RxBool checkingRoomTypes = false.obs;
  RxString roomTypesNotFound = RxString('');
  RxList<String> roomTypesDropDown = RxList<String>(<String>['']);
  RxList<String> vehicleTypeDropDown = RxList<String>(<String>['']);
  RxBool searchingRoomTypes = false.obs;
  Future<void> getRoomTypes() async {
    checkingRoomTypes.value = true;
    searchingRoomTypes.value = true;
    log('gjrjnijgjr');
    final List<int> roomIds = <int>[];
    final List<String> tourIds = <String>[];
    for (final TourModel tour in tours) {
      if (tour.tourName!.trim() == selectedTourWithoutTransit.trim()) {
        tourIds.add(tour.tourId!);
      }
    }
    for (final RoomCategoryModel room in roomCategoryModel) {
      if (room.catName!.trim() == selectedRoomCategory.trim()) {
        roomIds.add(int.parse(room.catId.toString()));
      }
    }

    try {
      await CustomBookingRepo()
          .getRoomtypes(tourIds, roomIds)
          .then((ApiResponse<List<String>> res) {
        if (res.data != null && res.data!.isNotEmpty) {
          roomTypes.value = res.data!;
          roomTypesDropDown.clear();
          final Set<String> uniqueValues =
              <String>{}; // Use a set to track unique values
          uniqueValues.clear();

          for (final String room in roomTypes) {
            if (room != null && !uniqueValues.contains(room)) {
              uniqueValues.add(room);
              roomTypesDropDown.add(room);
              for (int i = 0; i < nights.value; i++) {
                selectedRoomes['Night ${i + 1}'] = <SingleRoomModel>[];
              }
              // for (int i = 0; i < nights.value; i++) {
              //   roomPrice['Night ${i + 1}'] = {'': 0};
              // }

              log(selectedRoomes.toString());
            } else {
              // Debug statement for duplicate value
              // tourPdfEmpty = false;
            }
          }
          checkingRoomTypes.value = false;
          searchingRoomTypes.value = false;
        } else {
          checkingRoomTypes.value = false;

          searchingRoomTypes.value = false;
        }
      });
    } catch (e) {
      checkingRoomTypes.value = false;
      searchingRoomTypes.value = false;

      roomTypesNotFound.value = 'Room Types Not Found';

      log(e.toString());
    }
  }

  RxList<VehiclePriceModel> vehiclePriceModel = <VehiclePriceModel>[].obs;
  Map<String, num> allPricesOfVehicle = <String, num>{};
  Future<void> getVehiclePricesinPlaces(String placeId,
      List<String> vehicleNames, List<int> vehicleQty, int dayIndex) async {
    try {
      final List<String> vehicleIds = <String>[];
      for (final String e in vehicleNames) {
        final String id = vehicleModel.value
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
          vehiclePriceModel.value = res.data!;
          for (final VehiclePriceModel price in vehiclePriceModel) {
            prices.add(price.price!);
          }
          final num sum =
              prices.reduce((num value, num element) => value + element);
          allPricesOfVehicle['Day ${dayIndex + 1}'] = sum;

          log('allPricesOfVehicle $allPricesOfVehicle');
          log('allPricesOfVehicle $vehicleQuantity');
        } else {
          allPricesOfVehicle['Day ${dayIndex + 1}'] = 0;
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  RxMap<String, Map<num?, String>> activityAmount =
      <String, Map<num?, String>>{}.obs;

  RxList<AddonPriceModel> addonPriceModel = <AddonPriceModel>[].obs;
  Map<String, num> allPricesOfAddonVehicle = <String, num>{};
  Future<void> getVehiclePricesinAddons(List<String> addonIds,
      List<String> vehicleNames, List<int> vehicleQty, int dayIndex) async {
    try {
      final List<String> vehicleIds = <String>[];
      if (vehicleNames.isNotEmpty) {
        for (final String e in vehicleNames) {
          final String id = vehicleModel.value
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
            addonPriceModel.value = res.data!;
            for (final AddonPriceModel price in addonPriceModel) {
              prices.add(price.price!);
            }
            final num sum =
                prices.reduce((num value, num element) => value + element);
            allPricesOfAddonVehicle['Day ${dayIndex + 1}'] = sum;

            log('allPricesOfAddonVehicle $allPricesOfAddonVehicle');
          }
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  void createItineraryPDF() {
    showPreferenceAskingDialogue();
  }

  RxBool isProposal = true.obs;

  void showPreferenceAskingDialogue() {
    Get.dialog(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Align(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 45,
                  width: 220,
                  child: DefaultTextStyle(
                    style: subheading1.copyWith(),
                    child: const Text('Choose one!!',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        isProposal.value = true;
                        createItinerary();
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        foregroundColor: fontColor,
                        backgroundColor:
                            const Color.fromARGB(255, 232, 231, 233),
                      ),
                      child: const Text('Proposal Itinerary'),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: englishViolet),
                      onPressed: () async {
                        isProposal.value = false;
                        createItinerary();
                        Get.back();
                      },
                      child: const Text('Confirm Itinerary'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RxBool generatingPDF = false.obs;
  TeleCallerModel telecallerModel = TeleCallerModel();

  Future<void> createItinerary() async {
    generatingPDF.value = true;
    try {
      // final pw.Document pdf = pw.Document(title: 'Custom Itinerary');

      // await downloadImage(depImage)
      //     .then((String? value) => createPdf(pdf, value.toString()));

      // final Directory appDocDir = await getApplicationDocumentsDirectory();
      // final String pdfPath = '${appDocDir.path}/custom itinerary.pdf';
      // final File pdfFile = File(pdfPath);

      // await pdfFile.writeAsBytes(await pdf.save()).then(
      //       (File value) =>
      //           Get.toNamed(Routes.NO_INTERNET, arguments: <String>[pdfPath]),
      //     );
      // generatingPDF.value = false;
      // final List<Map<String, List<String>>?> inputMaps =
      //     <Map<String, List<String>>?>[
      //   placesForSingleDayName,
      //   addonsForSingleDayName,
      //   activitiesForSingleDayName,
      // ];

      final List<String> bookables = roomTypesDropDown + vehicleTypesDropDown;
      await postSnapshots();
      if (isProposal.value != true) {
        // final List<List<String>> resultList = combineMaps(inputMaps);
        final String id = tours
            .firstWhere((TourModel element) =>
                element.tourName == selectedTourWithoutTransit.value)
            .tourId
            .toString();
        //*********************************** */
        //list of tour ids
        // strt date
        // end date
        // day
        // night
        // adult
        // customer id
        // kid
        // infant
        // list of data
        // place id
        // addon id list
        // activity id list
        // vehicle id list
        // room id list
        //*********************************** */
        // CustomBookingRepo().customBooking(
        //   customerId: customerId.toString(),
        //   amountPayable: price.toString(),
        //   advPayment: '${advAmount.value + extraAdvAmount.value}',
        //   tasks: resultList,
        //   bookables: bookables,
        //   tourId: id,
        //   tourStartingDate: tourStartingDateTime.toString(),
        //   tourEndingDate: tourEndingDateTime.toString(),
        //   depID: depId.toString(),
        //   branchId: branchId.toString(),
        //   filePath: pdfPath,
        // );
      }
    } catch (e) {
      generatingPDF.value = false;

      log('PDF CREATE CATCH $e');
    }
  }

  List<List<String>> combineMaps(List<Map<String, List<String>>?> maps) {
    final List<List<String>> result = <List<String>>[];

    // Iterate over each map in the list
    for (final Map<String, List<String>>? inputMap in maps) {
      if (inputMap != null) {
        // Iterate over the keys in the current map
        inputMap.forEach((String day, List<String> activities) {
          final int key = int.tryParse(day.split(' ')[1]) ?? 0;

          // Ensure that result list has enough days to accommodate the current key
          while (result.length <= key) {
            result.add(<String>[]);
          }

          // Add items from the current map to the corresponding day's list
          result[key].addAll(activities);
        });
      }
    }

    return result;
  }

  RxMap<String, PlacesModel> placesForSingleDay = <String, PlacesModel>{}.obs;

  void createPdf(pw.Document pdf, String imageUrl) {
    final pw.MemoryImage image =
        pw.MemoryImage(File(imageUrl).readAsBytesSync());

    return pdf.addPage(
      pw.MultiPage(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        header: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Container(
                width: 100,
                height: 80,
                child: pw.Image(
                  height: 40,
                  image,
                  fit: pw.BoxFit.cover,
                ),
              ),
              pw.Divider(thickness: 2, color: PdfColors.grey),
              pw.SizedBox(height: 15)
            ],
          );
        },
        margin: const pw.EdgeInsets.symmetric(vertical: 30, horizontal: 25),
        pageFormat: PdfPageFormat.a3,
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Wrap(
              children: <pw.Widget>[
                pw.Header(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.white)),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: <pw.Widget>[
                      pw.Column(children: <pw.Widget>[
                        pw.Text(
                          selectedTourWithoutTransit.value,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        pw.Text(
                          '$days D | $nights N',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                if (isProposal.value != true)
                  pw.Header(
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.white)),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: <pw.Widget>[
                            pw.Text('CONFIRM ITINERARY',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 18))
                          ])),
                if (isProposal.value)
                  pw.Paragraph(
                    text:
                        '*Note : This is just a referral itinerary Upon confirmation, please get in touch with our executive and ask for your itinerary confirmation. The itinerary here is not valid for your tour.',
                    style: pw.TextStyle(
                        color: PdfColors.red900,
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold),
                  ),
                if (isProposal.value)
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: <pw.Widget>[
                      pw.Paragraph(
                        text: '''
*Note : This itinerary is only valid upto 5 days from ${DateTime.now().toDatewithMonthFormat()}''',
                        style: pw.TextStyle(
                            color: PdfColors.red900,
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                pw.ListView.builder(
                  itemCount: days.value,
                  itemBuilder: (pw.Context context, int dayIndex) {
                    final PlacesModel place =
                        placesForItinerary['Day ${dayIndex + 1}']
                            as PlacesModel;
                    return pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Header(
                          textStyle: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 24,
                          ),
                          child: pw.Text(
                            'Day ${dayIndex + 1}',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 20),
                          ),
                        ),

                        pw.Paragraph(
                          text: place.placeDes ?? '',
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                        // if (data.foodForSingleDay?['Day ${dayIndex + 1}']?.any(
                        //         (FoodModel food) =>
                        //             food.foodType == 'Break fast') ==
                        //     true)
                        //   pw.ListView.builder(
                        //       itemBuilder: (pw.Context context, int foodIndex) {
                        //         return pw.Row(children: <pw.Widget>[
                        //           pw.Paragraph(
                        //               text:
                        //                   'We will arrange you the ${data.foodForSingleDay?['Day ${dayIndex + 1}']?[foodIndex].foodType ?? ''} ${data.foodForSingleDay?['Day ${dayIndex + 1}']?[foodIndex].foodName ?? ''} on there . ')
                        //         ]);
                        //       },
                        //       itemCount: data
                        //               .foodForSingleDay?['Day ${dayIndex + 1}']
                        //               ?.length ??
                        //           0),
                        // pw.SizedBox(height: 10),
                        pw.Paragraph(
                            text:
                                '${placesForItinerary['Day ${dayIndex + 1}']}'),
                        if (vehiclesForItinerary['Day ${dayIndex + 1}'] !=
                                null &&
                            vehiclesForItinerary['Day ${dayIndex + 1}']!
                                    .isNotEmpty !=
                                false)
                          pw.Paragraph(
                            text:
                                '${vehiclesForItinerary['Day ${dayIndex + 1}']?.join(' and ')} will provide for the today journey',
                            style: const pw.TextStyle(fontSize: 14),
                          ),

                        // pw.SizedBox(height: 10),
                        pw.ListView.builder(
                            itemBuilder: (pw.Context context, int addonIndex) {
                              return pw.Paragraph(
                                text: addonsForItinerary['Day ${dayIndex + 1}']
                                            ?[addonIndex]
                                        .addonDes ??
                                    '',
                                style: const pw.TextStyle(fontSize: 14),
                              );
                            },
                            itemCount: addonsForItinerary['Day ${dayIndex + 1}']
                                    ?.length ??
                                0),
                        // pw.SizedBox(height: 10),
                        pw.ListView.builder(
                            itemBuilder:
                                (pw.Context context, int activityIndex) {
                              return pw.Paragraph(
                                text: activitiesForItinerary[
                                                'Day ${dayIndex + 1}']
                                            ?[activityIndex]
                                        .activityDes ??
                                    '',
                                style: const pw.TextStyle(fontSize: 14),
                              );
                            },
                            itemCount:
                                activitiesForItinerary['Day ${dayIndex + 1}']
                                        ?.length ??
                                    0),
                        // pw.SizedBox(height: 10),
                        if (roomsForItinerary['Night ${dayIndex + 1}'] !=
                                null &&
                            roomsForItinerary['Night ${dayIndex + 1}']!
                                    .isNotEmpty !=
                                false)
                          pw.ListView.builder(
                              itemBuilder: (pw.Context context, int roomIndex) {
                                return pw.Paragraph(
                                  text:
                                      'After the day ends we provide you  ${roomsForItinerary['Night ${dayIndex + 1}']?.join(' and ')} to stay the in the night ',
                                  style: const pw.TextStyle(fontSize: 14),
                                );
                              },
                              itemCount: 1),
                      ],
                    );
                  },
                ),
              ],
            ),
            pw.NewPage(),
            pw.Paragraph(
                text: 'HDFC BANK',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
            pw.Paragraph(text: 'Account Holder : TRIPPENS'),
            pw.Paragraph(text: 'Account Number : 50200065078880'),
            pw.Paragraph(text: 'IFSC           : HDFC0000057'),
            pw.Paragraph(text: 'Branch         : TRICHUR - PALACE ROAD'),
            pw.SizedBox(height: 13),
            pw.Paragraph(
                text: 'PAYMENT POLICY - ',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
            pw.Paragraph(
                text:
                    '> A minimum payment is required for booking a tour - Non refundable'),
            pw.Paragraph(
              text: '(The minimum payment will vary depending on the tour)',
              style: const pw.TextStyle(color: PdfColors.red900),
            ),
            pw.Paragraph(
              text:
                  '> 21-35 Days before date of departure : 50% of Cost \n 20 Days before date of departure : 100% of Total cost',
            ),
            pw.SizedBox(height: 13),
            pw.Paragraph(
                text: 'CANCELLATION AND REFUND POLICY  - ',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
            pw.Paragraph(
              text: '''
> 60 Days & Prior to Arrival POLICY - 25% of the Tour/Service Cost.
> 59 Days to 30 Days Prior To Arrival - 50% of the Tour/Service Cost.
> 29 Days to 15 Days Prior To Arrival - 75% of the Tour/Service Cost.
> 14 Days and less Prior To Arrival - No refund
> Transportation and accommodation are as per itinerary only, if you have to change any of the
same we will not be responsible for any kind of refund.
> There will be no refund for add-ons.
''',
            ),
            if (isProposal.value != true)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: <pw.Widget>[
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: <pw.Widget>[
                        pw.Text('Customer name : $customerName',
                            style: pw.TextStyle(
                                decorationThickness: 20,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text('Customer Id : $customerId'),
                        pw.Text(
                            'Tour date : ${tourStartingDateTime.toString().parseFrom24Hours().toDatewithMonthFormat()}',
                            style: pw.TextStyle(
                                decorationThickness: 20,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text('Adult (above 5 years):$adults ',
                            style: pw.TextStyle(
                                decorationThickness: 20,
                                fontWeight: pw.FontWeight.bold)),
                        if (kids != null)
                          pw.Text('kids :$kids ',
                              style: pw.TextStyle(
                                  decorationThickness: 20,
                                  fontWeight: pw.FontWeight.bold)),
                        if (infants != null && infants != 0)
                          pw.Text('kids :$infants ',
                              style: pw.TextStyle(
                                  decorationThickness: 20,
                                  fontWeight: pw.FontWeight.bold)),
                        pw.Text('Executive name : ${telecaCaller.userName}',
                            style: pw.TextStyle(
                                decorationThickness: 20,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text('Package Rate : $price /pax',
                            style: pw.TextStyle(
                                decorationThickness: 20,
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            'Advance amount : ${advAmount.value + extraAdvAmount.value} /pax',
                            style: pw.TextStyle(
                                decorationThickness: 20,
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold)),
                      ])
                ],
              ),
            pw.SizedBox(height: 20),
            pw.NewPage(),
            pw.Paragraph(
                text: 'TERMS AND CONDITIONS',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
            pw.Paragraph(
              text: '''
1. if you're not able to reach out the destination on time. That is not our responsibility
2. Hotel Check in time - 11.30 a.m. & checkout - 10.00 am.
3. The booking stands liable to be cancelled if 100% payment is not received less than 20 days before
date of departure. If the trip is cancel due to this reason advance will not be refundable. If you are
not pay the amount that in mentioned in payment policy then tour will be cancel.
4. There is no refund option in case you cancel the tour yourself.
5. All activities which are not mentioned in the above itinerary such as visiting additional spots or
involving in paid activities, If arranging separate cab etc. is not included in this.
6. In case of using additional transport will be chargeable.
7. All transport on the tour will be grouped together. Anyone who deviates from it will be excluded
from this package.
8. The company has the right for expelling persons who disagree with passengers or misrepresent
the company during the trip.
9. The company does not allow passengers to give tips to the driver for going additional spots.
10. In case of cancellation due to any reason such as Covid, strike, problems on the part of railways,
malfunctions, natural calamities etc., package amount will not be refunded.
11. The Company will not be liable for any confirmation of train tickets, flight tickets, other
transportation or any other related items not included in the package.
12. In Case Of Events And Circumstances Beyond Our Control, We Reserve The Right To Change All
Or Parts Of The Contents Of The Itinerary For Safety And Well Being Of Our Esteemed Passengers.
13. Bathroom Facility | Indian or European
14. In season rooms will not be the same as per itinerary but category will be the same (Budget
economy).
15. Charge will be the same from the age of 5 years.
16. We are not providing tourist guide, if you are taking their service in your own cost we will not be
responsible for the same.
17. You Should reach to departing place on time, also you should keep the time management or you
will not be able to cover all the place.
18. If the climate condition affect the sightseeing & activities that mentioned in itinerary, then we
won't provide you the additional spots apart from the itinerary.
19. Transportation timing 8 am to 6 pm, if use vehicle after that then cost will be extra
20. Will visit places as per itinerary only, if you visit other than this then cost will be extra
21. If any customers misbehave with our staffs improperly then we will cancel his tour immediately
and after that he can't continue with this tour.
22. If the trip is not fully booked or cancelled due to any special circumstances, we will postpone the
trip to another day. Otherwise, if the journey is to be done on the pre-arranged day, the customers
will have to bear the extra money themselves.
23. If you have any problems with the tour, please notify us as soon as possible so that we can
resolve the problem. If you raise the issue after the tour, we will not be able to help you.
24.Our company does not provide specific seats on the Volvo bus, if you need a seat particularly,
please let the executive know during the confirmation of your reservation.(requires additional
payment).
''',
            )
          ];
        },
        footer: (pw.Context context) {
          log('nm,.${context.pagesCount}');
          final String text =
              'Page ${context.pageNumber} of ${context.pagesCount} ';
          return pw.Container(
            // margin: const pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            alignment: pw.Alignment.centerRight,
            decoration:
                const pw.BoxDecoration(border: pw.Border(top: pw.BorderSide())),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Paragraph(
                    margin: const pw.EdgeInsets.all(10),
                    text: '''
A TOWER COMPLEX, KALVARY, JUNCTION, POOTHOLE ROAD,\nTHRISSUR, KERALA 680004 | 04872383104 | 0487238410''',
                    style: pw.TextStyle(fontNormal: pw.Font.courier())),
                pw.Text(text, style: const pw.TextStyle(color: PdfColors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> postSnapshots() async {
    final String tourid = tours
        .firstWhere((TourModel element) =>
            element.tourName == selectedTourWithoutTransit.value)
        .tourId
        .toString();
    final List<String> addonIds = <String>[];
    for (int i = 0; i < addonsForSingleDayName.length; i++) {
      if (addonsForSingleDayName['Day ${i + 1}'] != null &&
          addonsForSingleDayName['Day ${i + 1}']!.isNotEmpty) {
        // [Shalimar Garden , Nishanth]
        final List<String>? addData = addonsForSingleDayName['Day ${i + 1}'];
        for (final String data in addData!) {
          // Shalimar Garden
          final String? addonId = addonsModel['Day ${i + 1}']!
              .firstWhere(
                (AddonsModel element) => element.addonName == data,
                orElse: () => AddonsModel(),
              )
              .addonId;
          ////
          addonIds.add(addonId!);
        }
      }
    }
    log(addonIds.toString());
    log('placesForSingleDayName : $placesForSingleDayName');
    log('addonsForSingleDayName : $addonsForSingleDayName');
    log('activitiesForSingleDayName : $activitiesForSingleDayName');
    // final ItinerarySnapshotsData data = ItinerarySnapshotsData(
    //   activity: activityIds,
    //   addons: addonIds,
    //   room: roomIds,
    //   placeId: placeId,
    //   vehicle: vehicleIds,
    // );
    final List<ItinerarySnapshotsData> itinerarySnapshotsDataList =
        <ItinerarySnapshotsData>[];
    final SnapShotModel snapShotModel = SnapShotModel(
      adult: adults.value,
      data: itinerarySnapshotsDataList,
      day: days.value,
      endDate: tourEndingDateTime,
      startDate: tourStartingDateTime,
      infant: infants.value,
      kid: kids.value,
      night: nights.value,
      tourId: <String>[tourid],
      customerId: int.parse(customerId.toString()),
    );
    // CustomBookingRepo().postSnapshots(snapShotModel);
  }
}

final List<String> roomTypes = <String>[
  '2 Shared',
  '3 Shared',
  '4 Shared',
];

/*
{
    "tour_id": [2,3],
    "start_date": "2023-05-01",
    "end_date": "2023-07-04",
    "day": 4,
    "night": 3,
    "adult": 5,
    "customer_id": 10024,
    "kid": 9,
    "infant": 2,
    "data": [
        {
            "place_id": 1,
            "addons": [2,3],
            "activity": [4,5],
            "vehicle": [3,4],
            "room": [2,3],
            "food": [2,3]
        },
        {
            "place_id": 1,
            "addons": [2,3],
            "activity": [4,5],
            "vehicle": [3,4],
            "room": [2,3],
            "food": [2,3]
        },
        {
            "place_id": 1,
            "addons": [2,3],
            "activity": [4,5],
            "vehicle": [3,4],
            "room": [2,3],
            "food": [2,3]
        },
        {
            "place_id": 1,
            "addons": [2,3],
            "activity": [4,5],
            "vehicle": [3,4],
            "room": [2,3],
            "food": [2,3]
        }
    ]
}
*/
