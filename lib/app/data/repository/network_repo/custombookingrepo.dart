import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../services/dio_client.dart';
import '../../models/network_models/activity_model.dart';
import '../../models/network_models/addons_model.dart';
import '../../models/network_models/addons_price_model.dart';
import '../../models/network_models/checking_rooms_model.dart';
import '../../models/network_models/custom_snapshot_model.dart';
import '../../models/network_models/food_model.dart';
import '../../models/network_models/places_model.dart';
import '../../models/network_models/room_category_model.dart';
import '../../models/network_models/single_room_model.dart';
import '../../models/network_models/single_snapshot_model.dart';
import '../../models/network_models/single_vehicle_model.dart';
import '../../models/network_models/vehcile_category_model.dart';
import '../../models/network_models/vehicle_checking_model.dart';
import '../../models/network_models/vehicle_price_model.dart';

class CustomBookingRepo {
  Dio dio = Client().init();
  List<SingleRoomModel> singleRoomModel = <SingleRoomModel>[];
  List<SingleVehicleModel> vehicleCheckingModel = <SingleVehicleModel>[];
  List<PlacesModel> placesModel = <PlacesModel>[];
  List<ActivityModel> activityModel = <ActivityModel>[];
  List<AddonsModel> addonsModel = <AddonsModel>[];
  List<FoodModel> foodModel = <FoodModel>[];

  Future<ApiResponse<List<SingleRoomModel>>> checkRooms(
      RoomsCheckingModel rm) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('rooms/available'),
          data: rm.toJson(),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        singleRoomModel =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return SingleRoomModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<SingleRoomModel>>.completed(singleRoomModel);
      } else {
        return ApiResponse<List<SingleRoomModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<SingleRoomModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<SingleRoomModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<SingleVehicleModel>>> checkVehicles(
      VehicleCheckingModel vm) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('vehicles/available'),
          data: vm.toJson(),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        vehicleCheckingModel =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return SingleVehicleModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<SingleVehicleModel>>.completed(
            vehicleCheckingModel);
      } else {
        return ApiResponse<List<SingleVehicleModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<SingleVehicleModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<SingleVehicleModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<RoomCategoryModel>>> getRoomCategory(
      List<String> tourIds) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('rooms/roomcat'),
          data: <String, dynamic>{'tour': tourIds},
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        final List<RoomCategoryModel> roomCategoryList =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return RoomCategoryModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<RoomCategoryModel>>.completed(roomCategoryList);
      } else {
        return ApiResponse<List<RoomCategoryModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<RoomCategoryModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<RoomCategoryModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<VehcileCategoryModel>>> getVehicleCategory(
      List<String> tourIds) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('vehicles/vehiclecat'),
          data: <String, dynamic>{'tour': tourIds},
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        final List<VehcileCategoryModel> roomCategoryList =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return VehcileCategoryModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<VehcileCategoryModel>>.completed(
            roomCategoryList);
      } else {
        return ApiResponse<List<VehcileCategoryModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<VehcileCategoryModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<VehcileCategoryModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<PlacesModel>>> getPlaces(String tourId) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/places/?tour_id=$tourId'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        placesModel = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return PlacesModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<PlacesModel>>.completed(placesModel);
      } else {
        return ApiResponse<List<PlacesModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<PlacesModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<PlacesModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<VehiclePriceModel>>> getVehiclesInPlaces(
      VehiclePriceModel vpm) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('prices/place/getprice'),
          data: vpm.toJson(),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        final List<VehiclePriceModel> vehiclePriceModel =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return VehiclePriceModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<VehiclePriceModel>>.completed(
            vehiclePriceModel);
      } else {
        return ApiResponse<List<VehiclePriceModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<VehiclePriceModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<VehiclePriceModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<AddonPriceModel>>> getVehiclesInAddonss(
      AddonPriceModel apm) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('prices/addon/getprice'),
          data: apm.toJson(),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        final List<AddonPriceModel> addonPriceModel =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return AddonPriceModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<AddonPriceModel>>.completed(addonPriceModel);
      } else {
        return ApiResponse<List<AddonPriceModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<AddonPriceModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<AddonPriceModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<ActivityModel>>> getActivities(String placeId) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/activity/?place_id=$placeId'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        activityModel = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return ActivityModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<ActivityModel>>.completed(activityModel);
      } else {
        return ApiResponse<List<ActivityModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<ActivityModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<ActivityModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<AddonsModel>>> getAddons(String placeId) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/addons/?place_id=$placeId'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        addonsModel = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return AddonsModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<AddonsModel>>.completed(addonsModel);
      } else {
        return ApiResponse<List<AddonsModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<AddonsModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<AddonsModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<FoodModel>>> getFoods(String tourId) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('foods/?tour_id=$tourId'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        foodModel = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return FoodModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<FoodModel>>.completed(foodModel);
      } else {
        return ApiResponse<List<FoodModel>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<FoodModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<FoodModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> customBooking(
      {required String customerId,
      required String amountPayable,
      required String advPayment,
      required List<List<String>> tasks,
      required List<String> bookables,
      required String tourId,
      required String tourStartingDate,
      required String tourEndingDate,
      required String depID,
      required String branchId,
      required String filePath}) async {
    try {
      final String data = convertJsonToString(
        customerId: customerId,
        advPayment: advPayment,
        amountPayable: amountPayable,
        bookables: bookables,
        branchId: branchId,
        depID: depID,
        tasks: tasks,
        tourEndingDate: tourEndingDate,
        tourId: tourId,
        tourStartingDate: tourStartingDate,
      );

      final Map<String, dynamic>? authHeader =
          await Client().getMultiPartAuthHeader();
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'data': data,
        'pdf': await MultipartFile.fromFile(
          filePath,
          filename: 'custom itinerary.pdf',
          contentType: MediaType('application', 'pdf'),
        ),
      });
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('bookings'),
          data: formData,
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        return ApiResponse<Map<String, dynamic>>.completed(res.data);
      } else {
        return ApiResponse<Map<String, dynamic>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<Map<String, dynamic>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<Map<String, dynamic>>.error(e.toString());
    }
  }

  String convertJsonToString({
    required String customerId,
    required String amountPayable,
    required String advPayment,
    required List<List<String>> tasks,
    required List<String> bookables,
    required String tourId,
    required String tourStartingDate,
    required String tourEndingDate,
    required String depID,
    required String branchId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{
      'customer_id': customerId,
      'amount_payable': amountPayable,
      'advance_amount': advPayment,
      'tasks': tasks,
      'bookables': bookables,
      'tour_id': tourId,
      'start_date': tourStartingDate,
      'end_date': tourEndingDate,
      'dep_id': depID,
      'branch_id': branchId
    };
    final String jsonString = json.encode(data);
    return jsonString;
  }

  Future<ApiResponse<List<String>>> getRoomtypes(
      List<String> tourID, List<int> catID) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('rooms/types'),
          data: <String, dynamic>{'tour': tourID, 'cat': catID},
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        final List<dynamic> roomCategoryList =
            res.data!['result'] as List<dynamic>;
        final List<String> roomTypes =
            roomCategoryList.map((dynamic e) => e.toString()).toList();
        return ApiResponse<List<String>>.completed(roomTypes);
      } else {
        return ApiResponse<List<String>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<String>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<String>>.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> postSnapshots({
    required List<String> tourIds,
    required String tourStartingDate,
    required String tourEndingDate,
    required String day,
    required String night,
    required String adult,
    required String cid,
    required String kid,
    required String infant,
    required List<Map<String, dynamic>> data,
  }) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      log(authHeader!.values.toString());
      final Response<Map<String, dynamic>> res =
          await dio.postUri(Uri.parse('snapshots'),
              data: <String, Object>{
                'tour_id': tourIds,
                'start_date': tourStartingDate,
                'end_date': tourEndingDate,
                'day': day,
                'night': night,
                'adult': adult,
                'customer_id': cid,
                'kid': kid,
                'infant': infant,
                'data': data,
              },
              options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        return ApiResponse<Map<String, dynamic>>.completed(res.data);
      } else {
        return ApiResponse<Map<String, dynamic>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<Map<String, dynamic>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<Map<String, dynamic>>.error(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> postProposals({
    required String cid,
    required String pdf,
  }) async {
    try {
      final Map<String, dynamic>? authHeader =
          await Client().getMultiPartAuthHeader();
      log(authHeader!.values.toString());
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'customer_id': cid,
        'pdf': await MultipartFile.fromFile(
          pdf,
          filename: 'custom itinerary.pdf',
          contentType: MediaType('application', 'pdf'),
        ),
      });
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('proposals'),
          data: formData,
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        return ApiResponse<Map<String, dynamic>>.completed(res.data);
      } else {
        return ApiResponse<Map<String, dynamic>>.error(res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<Map<String, dynamic>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<Map<String, dynamic>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<CustomerSnapshotModel>>> getSnapshots(
      String customerId) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('snapshots?customer_id=$customerId'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        final List<CustomerSnapshotModel> snap =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return CustomerSnapshotModel.fromJson(e as Map<String, dynamic>);
        }).toList();

        return ApiResponse<List<CustomerSnapshotModel>>.completed(snap);
      } else {
        return ApiResponse<List<CustomerSnapshotModel>>.error(
            res.statusMessage);
      }
    } on DioException catch (de) {
      return ApiResponse<List<CustomerSnapshotModel>>.error(
          de.error.toString());
    } catch (e) {
      return ApiResponse<List<CustomerSnapshotModel>>.error(e.toString());
    }
  }

  Future<List<Result>> getSingleSnapshots(String shotId) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('snapshots/$shotId'),
          options: Options(headers: authHeader));
      log('Adeeb Api called');
      if (res.statusCode == 200) {
        log('Adeeb status code 200');
        log('Adeeb res data ${res.data}');
        final SingleSnapShotModel snap =
            SingleSnapShotModel.fromJson(res.data!);
        log('Adeeb res status ${res.statusMessage}');

        return snap.result!;
      } else {
        log('Adeeb else');
        log(' hb h ');
        return [];
      }
    } on DioException catch (de) {
      log('Adeeb Dio Exception $de');
      log(de.toString());
      return [];
    } catch (e) {
      log('Adeeb catch $e');
      return [];
    }
  }
}
