// ignore_for_file: unrelated_type_equality_checks, invalid_use_of_protected_member

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/theme/style.dart';
import '../../../../core/utils/string_utils.dart';
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
import '../custom_booking_functions/custom_booking_functions.dart';
import '../views/custom_booking_view.dart';

class CustomBookingController extends GetxController
    with StateMixin<CustomBookingView> {
  GlobalKey<FormState> formKey = GlobalKey();
  RxMap<String, List<Map<String, String>>> roomQuantityForItinerary =
      <String, List<Map<String, String>>>{}.obs;
  RxMap<String, List<Map<String, String>>> roomNameForItinerary =
      <String, List<Map<String, String>>>{}.obs;
  RxMap<String, List<Map<String, String>>> vehicleQuantityForItinerary =
      <String, List<Map<String, String>>>{}.obs;
  RxMap<String, List<Map<String, String>>> vehicleNameForItinerary =
      <String, List<Map<String, String>>>{}.obs;
  RxMap<String, List<Map<String, String>>> activitiesQuantityForItinerary =
      <String, List<Map<String, String>>>{}.obs;
  RxMap<String, bool> isFetchingData = <String, bool>{}.obs;
  RxMap<String, bool> fetchingActivities = <String, bool>{}.obs;
  RxMap<String, bool> fetchingAddons = <String, bool>{}.obs;
  RxInt days = 0.obs;
  RxInt nights = 0.obs;
  RxInt kids = 0.obs;
  RxInt infants = 0.obs;
  RxInt adults = 0.obs;
  RxBool tourSelected = false.obs;
  String? cid;
  RxString selectedRoomCategory = RxString('');
  String? tourStartingDateTime;
  String? tourEndingDateTime;
  Map<String, List<String>> activitiesForSingleDayName =
      <String, List<String>>{};
  Map<String, List<String>> foodsForSingleDayName = <String, List<String>>{};
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
  RxMap<String, List<FoodModel>> selectedFoods =
      <String, List<FoodModel>>{}.obs;
  RxMap<String, List<String>> selectedVehicles = <String, List<String>>{}.obs;
  RxMap<String, List<FoodModel>> selectedFoodsForTour =
      <String, List<FoodModel>>{}.obs;
  RxList<FoodModel> selectedFoodsForDays = <FoodModel>[].obs;
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
  RxMap<String, Map<String, dynamic>> itinerarySnapshots =
      <String, Map<String, dynamic>>{}.obs;
  final Map<String, String> itineraryString = <String, String>{};

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
  RxMap<String, List<Map<String, String>>?> foodsForItinerary =
      <String, List<Map<String, String>>?>{}.obs;
  RxMap<String, List<String>> roomstypesForItinerary =
      <String, List<String>>{}.obs;
  Rx<bool> onClickGenerateItinerary = false.obs;

  List<SingleRoomModel> selectedRoomsForDropDown = <SingleRoomModel>[];
  List<SingleVehicleModel> selectedVehicleForDropDown = <SingleVehicleModel>[];
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
  TeleCallerModel telecaCaller = TeleCallerModel();
  Rx<bool> isCheckingPlaces = false.obs;

  RxBool isProposal = true.obs;

  RxMap<String, Map<num?, String>> activityAmount =
      <String, Map<num?, String>>{}.obs;

  RxBool generatingPDF = false.obs;
  TeleCallerModel telecallerModel = TeleCallerModel();
  final List<List<String>> result = <List<String>>[];
  final List<ItinerarySnapshotsData> itinerarySnapshotsDataList =
      <ItinerarySnapshotsData>[];
  RxMap<String, PlacesModel> placesForSingleDay = <String, PlacesModel>{}.obs;

  RxList<AddonPriceModel> addonPriceModel = <AddonPriceModel>[].obs;
  Map<String, num> allPricesOfAddonVehicle = <String, num>{};
  RxList<VehiclePriceModel> vehiclePriceModel = <VehiclePriceModel>[].obs;
  Map<String, num> allPricesOfVehicle = <String, num>{};
  RxList<String> roomTypes = <String>[].obs;
  RxBool checkingRoomTypes = false.obs;
  RxList<String> roomTypesDropDown = RxList<String>(<String>['']);
  RxList<String> vehicleTypeDropDown = RxList<String>(<String>['']);
  RxBool searchingRoomTypes = false.obs;
  num price = 0.0;
  RxInt advAmount = 2000.obs;
  RxInt extraAdvAmount = 0.obs;
  RxList<String> toursIds = <String>[].obs;
  RxMap<String, Map<String, int>> roomPrice = <String, Map<String, int>>{}.obs;
  RxMap<String, Map<String, int>> foodPrice = <String, Map<String, int>>{}.obs;
  RxMap<String, Map<String, int>> vehiclePrice =
      <String, Map<String, int>>{}.obs;

  RxList<String> vehicleTypesDropDown = <String>[].obs;
  Rx<bool> isCheckingVehicle = false.obs;
  Rx<bool> isGettingRooms = false.obs;
  RxMap<String, int> selectedRoomTypePrices = <String, int>{}.obs;
  RxList<SingleRoomModel> selectedRoomTypeNamesToDropDown =
      <SingleRoomModel>[].obs;
  RxList<String> selectedRoomTypeNames = <String>[].obs;
  Rx<bool> isGettingVehicleCategory = false.obs;
  RxList<String> vehicleCtegoryDropDown = RxList<String>(<String>['']);

  Rx<bool> isCheckingRoomCategory = false.obs;
  RxList<String> roomCategoryDropDown = RxList<String>(<String>['']);

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      tours.value = Get.arguments[0] as List<TourModel>;
      customerId = Get.arguments[1] as String;
      customerName = Get.arguments[2] as String;
      cid = Get.arguments[3] as String;
      tourValues.clear();
      telecaCaller = await storage.read('telecaller_data') as TeleCallerModel;

      await loadTours();

      change(null, status: RxStatus.success());
    }
  }

  Future<void> loadTours() async {
    try {
      final ApiResponse<List<TourModel>> response = await ToursRepository()
          .getAllToursInDepartment(telecaCaller.depId.toString());
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
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getAddons(String placeId, String dayKey, int dayIndex) async {
    try {
      fetchingAddons['Day ${dayIndex + 1}'] = true;
      final ApiResponse<List<AddonsModel>> res =
          await CustomBookingRepo().getAddons(placeId);

      if (res.data!.isNotEmpty) {
        addonsModel[dayKey] = res.data!;
        addonValues.clear();
        fetchingAddons['Day ${dayIndex + 1}'] = false;
      }
    } catch (e) {
      fetchingAddons['Day ${dayIndex + 1}'] = false;

      log('room $e');
    }
  }

  Future<void> getActivities(
      String placeId, String dayKey, int dayIndex) async {
    if (activityModel.containsKey(dayKey)) {
      activityModel[dayKey]!.clear();
    }
    try {
      final ApiResponse<List<ActivityModel>> res =
          await CustomBookingRepo().getActivities(placeId);

      if (res.data!.isNotEmpty) {
        activityModel[dayKey] = res.data!;
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
        for (int i = 0; i < days.value; i++) {
          selectedFoodsForTour['Day ${i + 1}'] = <FoodModel>[];
        }
        for (int i = 0; i < days.value; i++) {
          selectedFoods['Day ${i + 1}'] = <FoodModel>[];
        }
      } else {
        searchingFood.value = false;
      }
    } catch (e) {
      searchingFood.value = false;

      log('room $e');
    }
  }

  String? validateSelectedTourStartingDateTime(String? value) =>
      DateTime.tryParse(value ?? '') != null
          ? null
          : 'Add Tour Starting Date and Time';

  String? validateSelectedTourEndingDateTime(String? value) =>
      DateTime.tryParse(value ?? '') != null
          ? null
          : 'Add Tour Ending Date and Time';

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

  Future<void> onClickCreateItinerary() async {
    onClickGenerateItinerary.value = true;

    if (formKey.currentState!.validate()) {
      if (isTransit.value) {
      } else {
        if (selectedTourWithoutTransit.isNotEmpty) {
          final DateTime date1 = DateTime.parse(
              tourStartingDateTime.toString().toDateOnly().toString());
          final DateTime date2 = DateTime.parse(
              tourEndingDateTime.toString().toDateOnly().toString());

          final Duration tdays = date2.isAfter(date1)
              ? date2.difference(date1)
              : date1.difference(date2);
          final Duration totalDaysNeeded = tdays + const Duration(days: 1);
          final int totalDaysAdded = days.value;

          if (totalDaysNeeded.inDays != totalDaysAdded) {
            CustomToastMessage().showCustomToastMessage('Dates not matched');
            onClickGenerateItinerary.value = false;
          } else {
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
            if (nights.value == 0) {
              CustomToastMessage().showCustomToastMessage('Add Nights');
            } else if (roomPrice.isEmpty && roomPrice == null) {
              CustomToastMessage()
                  .showCustomToastMessage('Check the room details');
            } else if (days.value == 0) {
              CustomToastMessage().showCustomToastMessage('Add Days');
            } else if (vehiclesForItinerary.isEmpty &&
                vehiclesForItinerary == null) {
              CustomToastMessage()
                  .showCustomToastMessage('Check the vehicle details');
            } else {
              final String tourId = tours.value
                  .firstWhere((TourModel element) =>
                      element.tourName == selectedTourWithoutTransit.value)
                  .tourId!;
              await getPlaces(tourId);

              firstPhaseCompleted.value = true;
              onClickGenerateItinerary.value = false;
            }
          }
        }
      }
    } else {
      onClickGenerateItinerary.value = false;

      CustomToastMessage().showCustomToastMessage('Fields are mandatory');
    }
  }

  Future<void> getPlaces(String tourId) async {
    isCheckingPlaces.value = true;

    try {
      final ApiResponse<List<PlacesModel>> response =
          await CustomBookingRepo().getPlaces(tourId);

      if (response.data != null && response.data!.isNotEmpty) {
        placesModel.value = response.data!;

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
        log('1');
        for (final RoomCategoryModel room in roomCategoryModel) {
          if (room.catId != null &&
              !uniqueValues.contains(room.catName.toString())) {
            log('2');
            uniqueValues.add(room.catName.toString());
            roomCategoryDropDown.add(room.catName.toString());
            log(roomCategoryDropDown.toString());
          } else {
            log('3');
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
      log(e.toString());
      isCheckingRoomCategory.value = false;
      searchingRooms.value = false;
    }
  }

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

  Future<void> getRooms(
      List<String> roomtypes, List<String> roomCategories) async {
    isGettingRooms.value = true;

    await checkToursNonTransit(
            roomCategories: roomCategories, roomTypes: roomtypes)
        .then((dynamic value) => isGettingRooms.value = false);
  }

  Future<void> checkVehicleAvailability(
      {required List<String> vehicleCatyegory}) async {
    log('Kiimii 1');
    isCheckingVehicle.value = true;
    searchingVehicles.value = true;
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
        searchingVehicles.value = false;

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
        searchingVehicles.value = false;
      }
    } catch (e) {
      searchingVehicles.value = false;
      log('Kiimii 4');

      checkingAvailabilty.value = false;
      isCheckingVehicle.value = false;
      log('veh $e');
    }
  }

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

  Future<void> calculateCost({
    required BuildContext context,
  }) async {
    log('guhffj $itinerarySnapshots');
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

      final num totalCost = calculateTotalCost(
          roomPrice,
          allPricesOfAddonVehicle,
          allPricesOfVehicle,
          activityAmount.value,
          foodPrice);
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
                  Text('Package amount : ${price.round()} /pax',
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
                  }),
                  const SizedBox(height: 10),
                  Text(
                      'You will get 🪙 ${getPoints(price)} points /pax for this tour ',
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
    log('vgbhkjml,;activityAmount $selectedFoodsForDays');
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

      log(e.toString());
    }
  }

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

  void createItineraryPDF(CustomBookingController controller) {
    final Map<String, String> vehiclesOnDay = <String, String>{};
    vehicleNameForItinerary
        .forEach((String key, List<Map<String, String>> value) {
      final List<String> descriptions = <String>[];
      for (int i = 0; i < value.length; i++) {
        final String name = value[i]['vehicle_name']!;
        final String quantity = vehicleQuantityForItinerary[key]![i]['qty']!;
        descriptions.add('$quantity $name');
      }
      final String journeyDescription =
          "For today's journey ${descriptions.join(' and ')} is arranged for ${adults.value} pax";
      vehiclesOnDay[key] = journeyDescription;
    });
    //////
    final Map<String, String?> roomsOnDay = <String, String?>{};
    roomNameForItinerary.forEach((String key, List<Map<String, String>> value) {
      final List<String> descriptions = <String>[];
      for (int i = 0; i < value.length; i++) {
        final String name = value[i]['room_name']!;
        final String quantity = roomQuantityForItinerary[key]![i]['qty']!;
        descriptions.add('$quantity $name');
      }
      final String journeyDescription =
          "AfterWards you will accomadate on ${descriptions.join(' and ')} for ${adults.value + kids.value} pax";
      roomsOnDay[key] = journeyDescription;
    });
    log(roomsOnDay.toString());
    /////
    final Map<String, String> breakFastString = <String, String>{};
    for (int i = 0; i < days.value; i++) {
      breakFastString['Day ${i + 1}'] = '';
    }
    for (int j = 0; j < days.value; j++) {
      if (foodsForItinerary['Day ${j + 1}'] != null) {
        for (final Map<String, String> item
            in foodsForItinerary['Day ${j + 1}']!) {
          item.containsKey('Break fast')
              ? breakFastString['Day ${j + 1}'] = item['Break fast']!
              : breakFastString['Day ${j + 1}'] = '';
        }
      } else {
        breakFastString['Day ${j + 1}'] = '';
      }
    }
    final Map<String, String> lunchString = <String, String>{};
    for (int i = 0; i < days.value; i++) {
      lunchString['Day ${i + 1}'] = '';
    }
    for (int j = 0; j < days.value; j++) {
      if (foodsForItinerary['Day ${j + 1}'] != null) {
        for (final Map<String, String> item
            in foodsForItinerary['Day ${j + 1}']!) {
          item.containsKey('Lunch')
              ? lunchString['Day ${j + 1}'] = item['Lunch']!
              : lunchString['Day ${j + 1}'] = '';
        }
      } else {
        lunchString['Day ${j + 1}'] = '';
      }
    }
    final Map<String, String> dinnerString = <String, String>{};
    for (int i = 0; i < days.value; i++) {
      dinnerString['Day ${i + 1}'] = '';
    }
    for (int j = 0; j < days.value; j++) {
      if (foodsForItinerary['Day ${j + 1}'] != null) {
        for (final Map<String, String> item
            in foodsForItinerary['Day ${j + 1}']!) {
          item.containsKey('Dinner')
              ? dinnerString['Day ${j + 1}'] = item['Dinner']!
              : dinnerString['Day ${j + 1}'] = '';
        }
      } else {
        dinnerString['Day ${j + 1}'] = '';
      }
    }

    String roomString = '';
    final Map<String, List<String>> activitiesList = <String, List<String>>{};
    for (int i = 0; i < days.value; i++) {
      activitiesList['Day ${i + 1}'] = <String>[];
    }
    for (var i = 0; i < days.value; i++) {
      for (final ActivityModel element
          in activitiesForItinerary['Day ${i + 1}']!) {
        activitiesList['Day ${i + 1}']!.add(element.activityDes.toString());
      }
    }
    final Map<String, List<String>> activitiesString =
        activityString(activitiesQuantityForItinerary.value, activitiesList);

    for (int i = 0; i < days.value; i++) {
      if (roomsOnDay['Night ${i + 1}'] == null) {
        roomString = '';
      } else {
        roomString = roomsOnDay['Night ${i + 1}']!;
      }
      itineraryString['Day ${i + 1}'] =
          placesForItinerary['Day ${i + 1}']!.placeDes! +
              vehiclesOnDay['Day ${i + 1}']! +
              breakFastString['Day ${i + 1}']! +
              addonsForItinerary['Day ${i + 1}']!
                  .map((AddonsModel e) => e.addonDes)
                  .join(' ') +
              lunchString['Day ${i + 1}']! +
              // activitiesForItinerary['Day ${i + 1}']!
              //     .map((ActivityModel e) => e.activityDes)
              //     .join(' ') +
              activitiesString['Day ${i + 1}']!.join(' and ') +
              roomString +
              dinnerString['Day ${i + 1}']!;
    }
    log(itinerarySnapshots.toString());

    showPreferenceAskingDialogue(controller);
  }

  Map<String, List<String>> activityString(
      Map<String, List<Map<String, String>>> dayToPassengers,
      Map<String, List<String>> dayToActivities) {
    final Map<String, List<String>> result = <String, List<String>>{};
    log('daytopassenger $dayToPassengers');
    log('daytoactivites $dayToActivities');
    dayToPassengers
        .forEach((String day, List<Map<String, String>> passengerObjects) {
      final List<String> activities = dayToActivities[day] ?? <String>[];
      final List<String> combinedInfo = <String>[];

      if (passengerObjects.isNotEmpty && activities.isNotEmpty) {
        for (int i = 0; i < passengerObjects.length; i++) {
          final Map<String, String> passengerInfo = passengerObjects[i];
          final String activity = activities[i % activities.length];
          final int passengerCount =
              int.tryParse(passengerInfo['qty'] ?? '0') ?? 0;
          if (passengerCount > 0) {
            combinedInfo.add('$activity for $passengerCount pax');
          }
        }
      }

      result[day] = combinedInfo;
    });
    log('result $result');

    return result;
  }

  void showPreferenceAskingDialogue(CustomBookingController controller) {
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
                        createItinerary(controller);
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
                        createItinerary(controller);
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

  Future<void> createItinerary(CustomBookingController controller) async {
    generatingPDF.value = true;

    try {
      final pw.Document pdf = pw.Document(title: 'Custom Itinerary');

      await downloadImage(telecaCaller.depImage.toString()).then(
          (String? value) => createPdf(pdf, value.toString(), controller));
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String pdfPath = '${appDocDir.path}/custom itinerary.pdf';
      final File pdfFile = File(pdfPath);

      await pdfFile.writeAsBytes(await pdf.save()).then(
            (File value) => Get.toNamed(Routes.PDF,
                arguments: <String>[pdfPath, customerId.toString()]),
          );
      generatingPDF.value = false;
      final List<Map<String, List<String>>?> inputMaps =
          <Map<String, List<String>>?>[
        placesForSingleDayName,
        addonsForSingleDayName,
        activitiesForSingleDayName,
        foodsForSingleDayName
      ];

      final List<String> bookables = roomTypesDropDown + vehicleTypesDropDown;
      await postSnapshots();
      if (isProposal.value != true) {
        final List<List<String>> resultList = combineMaps(inputMaps);
        final String id = tours
            .firstWhere((TourModel element) =>
                element.tourName == selectedTourWithoutTransit.value)
            .tourId
            .toString();

        CustomBookingRepo().customBooking(
          customerId: customerId.toString(),
          amountPayable: price.toString(),
          advPayment: '${advAmount.value + extraAdvAmount.value}',
          tasks: resultList,
          bookables: bookables,
          tourId: id,
          tourStartingDate: tourStartingDateTime.toString(),
          tourEndingDate: tourEndingDateTime.toString(),
          depID: telecaCaller.depId.toString(),
          branchId: telecaCaller.branchId.toString(),
          filePath: pdfPath,
        );
      }
    } catch (e) {
      generatingPDF.value = false;

      log('PDF CREATE CATCH $e');
    }
  }

  List<List<String>> combineMaps(List<Map<String, List<String>>?> maps) {
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

  Future<void> postSnapshots() async {
    final String tourid = tours
        .firstWhere((TourModel element) =>
            element.tourName == selectedTourWithoutTransit.value)
        .tourId
        .toString();
    final List<String> tourIds = <String>[];
    tourIds.add(tourid);
    CustomBookingRepo().postSnapshots(
        adult: adults.value.toString(),
        cid: customerId.toString(),
        data: itinerarySnapshots.values.toList(),
        day: days.value.toString(),
        infant: infants.value.toString(),
        kid: kids.value.toString(),
        night: nights.value.toString(),
        tourEndingDate: tourEndingDateTime.toString(),
        tourStartingDate: tourStartingDateTime.toString(),
        tourIds: tourIds);
  }

  num getPoints(num price) {
    final num amount = price * 0.03;
    final num points = amount / 20;
    return points.round();
  }
}
